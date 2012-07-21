# encoding: UTF-8

require 'chordie-how/utils'
require 'chordie-how/constants'
require 'chordie-how/stringed/constants'

module ChordieHow::Stringed
  module Utils
    include ChordieHow::Utils
    include ChordieHow::Constants
    include ChordieHow::Stringed::Constants

    # check to see if we have a :limit option and it's valid.
    def have_limit?(l)
      l.nil? ? false : Kernel.Integer(l) rescue false
    end

    # returns the notes found on open strings.
    def find_open_strings(tuning, capo = 0)
      begin
        t = if [ Symbol, String ].include?(tuning.class)
          tuning = tuning.to_sym
          if TUNINGS[tuning]
            TUNINGS[tuning][:tuning]
          else
            raise "not found in TUNINGS"
          end
        elsif tuning.is_a?(Array)
          tuning
        else
          raise "must be a Symbol, String or Array"
        end
      rescue Exception => e
        raise ChordieHow::BadTuning.new(tuning, e.message)
      end

      t.collect do |v|
        if v =~ /^\d+$/
          (v.to_i + capo).modulo(NOTES.length)
        else
          (NOTES.index(v.upcase) + capo.to_i).modulo(NOTES.length)
        end
      end
    end

    # find the name of the notes in n. n will be converted to an Array,
    # and the method itself always returns an Array.
    def find_notes(n, capo = 0)
      if n.is_a?(Array)
        n.collect do |x|
          find_note_from_index(x + capo)
        end
      else
        find_note_from_index(n + capo)
      end
    end


    # the big chord finding function... pretty crazy...
    #
    # * :key is a note from NOTES
    # * :type is a chord type from CHORD_TYPES
    # * :tuning is a tuning from TUNINGS
    # * :span is an integer indictating possible fingerspan on the
    #   fretboard
    # * :capo is the fret number the capo is on
    # * :inversions is a boolean to determine whether or not we should
    #    look for any inversions
    # * :limit the number of results
    def find_chords(key, type, options = {})
      options = {
        :tuning => :guitar_standard,
        :span => 3,
        :min_fret => 0,
        :max_fret => 12,
        :capo => 0,
        :inversions => false,
        :limit => nil
      }.merge options

      # return right away if :limit is less than or equal to zero
      # since there's not much point in continuing.
      return [] if (have_limit?(options[:limit]) && options[:limit].to_i <= 0)

      raise StringedException, "Please keep your frets to less than 32" if options[:max_fret].to_i > 32 || options[:min_fret].to_i > 32

      chord_notes = find_chord_notes(key, type)

      # figure out our open string notes...
      strings = find_open_strings(options[:tuning], options[:capo])

      # figure out possible places for notes on the fretboard.
      # Basically, we create an index of possible fingerings within
      # each section of the fretboard within our possible finger
      # span.
      fingerings = Array.new
      (options[:min_fret].to_i..(options[:max_fret].to_i - options[:span].to_i)).each do |i|
        idx = Hash.new

        (i..(i + options[:span].to_i)).each do |fret|
          strings.length.times do |string|
            idx[string] ||= Hash.new
            n = find_note_from_index(strings[string] + fret)
            if chord_notes.index(n)
              idx[string][fret] = n
            else
              n = find_note_from_index(strings[string])
              if chord_notes.index(n)
                idx[string][0] = n
              end
            end
          end
        end

        idx.each_pair do |k, v|
          idx.delete k if v.empty?
        end

        fingerings << idx
      end

      # now that we have possible finger positions, figure out actual
      # chords. Since there can be multiple possibilities for notes
      # on each string within our fretable span, we may need to
      # construct multiple voicings based on each section of the
      # fretboard.
      retval = Array.new
      fingerings.each do |f|
        break if have_limit?(options[:limit]) && retval.length >= options[:limit].to_i

        # see if there's multiple notes on each string. If there
        # is, we need to construct new shapes for each. If there
        # are multiple notes on a string then we expand these.
        # There should be 2 ^ multiple combinations. We may not
        # have to use all of them, as we'll filter out duplicates
        # later.
        if f.collect { |x| x[1].length }.detect { |x| x > 1 }
          chords = Array.new
          f.sort_by { |x| x[0] }.each do |string, frets|
            if chords.empty?
              frets.each do |k, v|
                chords << { string => { k => v } }
              end
            else
              temp = Array.new
              chords.each do |c|
                frets.each do |k, v|
                  c[string] = { k => v }
                  temp << c.dup
                end
              end
              if !temp.empty?
                chords = temp
              end
            end
          end

          # now we need to go through each chord and refine it so
          # our bass note is the first in line. If we don't
          # bother to do this step, then you'll get all of the
          # possible inversions in the resulting array.
          unless options[:inversions]
            chords.each_with_index do |c, i|
              unless refine_chord(key, c, chord_notes)
                chords[i] = nil
              end
            end
          end

          chords.compact!

          # finally, filter out all duplicates and invalid
          # chords, i.e. any chords we constructed that don't
          # contain all of the required notes.
          chords.each_with_index do |c, i|
            retval << c if check_chord(c, chord_notes) && !retval.include?(c)
            break if have_limit?(options[:limit]) && retval.length >= options[:limit].to_i
          end

        # If there are no strings with multiple notes, just add the
        # chord to the pile.
        else
          unless options[:inversions]
            refine_chord(key, f, chord_notes)
          end
          retval << f if check_chord(f, chord_notes) && !retval.include?(f)
        end
      end

      retval.collect do |c|
        Chord.new(key, c, :type => type, :tuning => options[:tuning], :capo => options[:capo])
      end
    end

    protected

    # This little method is used to clean up a chord and get rid of
    # any inversions, leaving the bass note as the root.
    def refine_chord(key, chord, chord_notes)
      bass = false
      got = Hash.new
      chord.sort_by { |x| x[0] }.each do |k, v|
        value = v.values.first
        if value == key
          bass = true
          got[value] = true
        elsif bass
          got[value] = true
        else
          chord.delete k
        end
      end
      got.length == chord_notes.length
    end

    # Sanity check to make sure a chord is valid.
    def check_chord(chord, chord_notes)
      n = chord.values.collect { |x| x.values }.flatten.uniq
      if (n & chord_notes).length == chord_notes.length
        true
      else
        false
      end
    end
  end
end

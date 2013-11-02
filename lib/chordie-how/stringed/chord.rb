# encoding: UTF-8

require 'builder'

require 'chordie-how/utils'
require 'chordie-how/midi'
require 'chordie-how/image'
require 'chordie-how/stringed/constants'
require 'chordie-how/stringed/utils'

# The Chord class is used for displaying a chord. Generally, this is
# something you'd want to use via the find_chords method rather than
# instantiating directly, unless you happen to know how to fill the
# fingering Hash.
class ChordieHow::Stringed::Chord
  include ChordieHow::Stringed
  include ChordieHow::Midi
  include ChordieHow::Image
  include ChordieHow::Utils

  include ChordieHow::Stringed::Utils
  include ChordieHow::Stringed::Constants

  attr_reader :key, :fingering, :type, :capo, :max_fret,
    :min_fret, :notes, :intervals, :tuning_notes

  # * key is the key of the chord, from NOTES.
  # * fingering is a Hash that represents what notes to fret on what
  #   strings. This is a fairly involved ordeal, but look at
  #   find_chords for somewhat of an explanation.
  #
  # Most of the options below are for display and informational
  # purposes. Since we should already have the fingering figured out,
  # we don't actually use any of these options for processing or
  # otherwise building the chord. That's taken care of in find_chords
  # or (if you're adventurous) manually.
  #
  # * :tuning - the tuning to use for the open strings, either as a
  #   Symbol representing an entry in CHORD_TYPES or as an Array of
  #   intervals. The default is the standard for a six-string guitar
  #   (EADGBE).
  # * :capo - a fret that for a capo. The output becomes relative to
  #   the capo's position. The default is 0.
  # * :type - the type of chord we're dealing with here. The default
  #   is nil.
  def initialize(key, fingering, options = {})
    options = {
      :tuning => :guitar_standard,
      :capo => 0,
      :type => nil
    }.merge options

    @key = key
    @fingering = self.parse_fingering(fingering)
    @type = options[:type]
    @capo = options[:capo]
    @notes = @fingering.collect { |x| x[1].values.first.to_s }.uniq
    @intervals = find_intervals(@key, @notes)
    @tuning = find_open_strings(options[:tuning], options[:capo])
    @tuning_notes = find_notes(@tuning)

    # figure out the maximum and minimum frets to display...
    frets = @fingering.collect { |k, v| v.keys }.flatten.uniq.sort
    if frets.first == 0 && frets.length > 1
      @min_fret = frets[1]
    else
      @min_fret = frets.first
    end
    @max_fret = frets.max
  end

  # Returns the tuning as in Array in numerical form, where A == 0,
  # B == 2, C == 3, etc.
  def tuning_no
    @tuning
  end

  # Builds and returns the chord in an HTML table.
  def to_html(options = {})
    options = {
      :class => 'chord-diagram',
      :highlight_intervals => true,
      :embed_styles => false,
      :show_notes => true,
      :lefty => false
    }.merge options

    # Duplicate @tuning so we can reverse if if we're a lefty and
    # not disturb the original tuning order.
    tuning_range = @tuning.dup
    tuning_range.reverse! if options[:lefty]
    td_style = build_css(CSS_STYLES[:'table.scale-diagram td']) if options[:embed_styles]

    xml = Builder::XmlMarkup.new(:indent => 4)
    xml.table(:class => options[:class]) do
      if options[:show_notes]
        xml.tr do
          if options[:embed_styles]
            xml.td(:style => td_style) { xml << '&nbsp;' }
          else
            xml.td('')
          end

          tuning_range.each_with_index do |t, s|
            s = tuning_range.length - s - 1 if options[:lefty]
            attributes = if options[:embed_styles]
              { :style => td_style }
            end
            xml.td(@tuning_notes[s], attributes)
          end
        end

        xml.tr do
          if options[:embed_styles]
            xml.td(:style => td_style) { xml << '&nbsp;' }
          else
            xml.td('')
          end

          tuning_range.each_with_index do |t, s|
            s = tuning_range.length - s - 1 if options[:lefty]
            klass, note_text = if @fingering[s]
              if @notes.include?(@fingering[s].values.first.to_s)
                note = @fingering[s].values.first.to_s
                klass = if options[:highlight_intervals]
                  interval_to_html_class(@intervals, note)
                else
                  'note'
                end
                [ klass, note ]
              end
            else
              [ 'muted', 'x' ]
            end

            attributes = {
              :class => klass
            }

            if options[:embed_styles]
              attributes.merge!(
                :style => "#{td_style} #{interval_class_to_style(klass)}"
              )
            end

            xml.td(note_text, attributes)
          end
        end
      end

      ((@min_fret)..(@max_fret)).each do |f|
        xml.tr do
          if options[:embed_styles]
            xml.td(f, :style => td_style)
          else
            xml.td(f)
          end

          tuning_range.each_with_index do |t, s|
            s = tuning_range.length - s - 1 if options[:lefty]
            n = find_notes(t + f).to_s
            klass, style = if @fingering[s] && @fingering[s][f] == n
              if options[:highlight_intervals]
                klass = interval_to_html_class(@intervals, n)
                style = if options[:embed_styles]
                  interval_class_to_style(klass)
                end
                [ klass, style ]
              else
                [ 'note',
                  (options[:embed_styles] ?
                    interval_class_to_style('note') :
                    nil
                  )
                ]
              end
            end

            attributes = if klass
              { :class => klass }
            else
              Hash.new
            end

            if options[:embed_styles]
              attributes.merge!(
                :style => "#{td_style} #{style}"
              )
            end

            xml.td(attributes) do
              xml << (options[:show_notes] ? n : '&nbsp;')
            end
          end
        end
      end
    end
  end
  alias :to_xml :to_html

  # Builds a String that can be used to display the chord as plaintext.
  def to_txt(options = {})
    options = {
      :lefty => false
    }.merge options

    retval = '    '
    tuning_range = @tuning.dup
    tuning_range.reverse! if options[:lefty]

    tuning_range.each_with_index do |t, s|
      s = tuning_range.length - s - 1 if options[:lefty]
      retval << @tuning_notes[s].ljust(3)
    end
    retval << "\n    "

    tuning_range.each_with_index do |t, s|
      s = tuning_range.length - s - 1 if options[:lefty]
      if @fingering[s]
        retval << @fingering[s].values.first.to_s.ljust(3)
      else
        retval << 'x'.ljust(3)
      end
    end
    retval << "\n"

    ((@min_fret)..(@max_fret)).each do |f|
      retval << f.to_s.rjust(2) + '  '
      tuning_range.each_with_index do |t, s|
        s = tuning_range.length - s - 1 if options[:lefty]
        n = find_notes(t + f).to_s
        if @fingering[s] && @fingering[s][f] == n
          retval << 'o'.ljust(3)
        else
          retval << '   '
        end
      end
      retval << "\n"
    end
    return retval
  end

  # Returns a one-liner chord diagram.
  def to_s(options = {})
    options = {
      :lefty => false
    }.merge options

    @tuning.length.times.collect { |s|
      s = @tuning.length - s - 1 if options[:lefty]
      if @fingering[s]
        @fingering[s].keys
      else
        'x'
      end
    }.join(' ')
  end

  def to_a
    @fingering.to_a
  end

  def to_h
    @fingering
  end

  def to_midi(options = {})
    last_note = nil
    octave = 0
    midi_notes = @fingering.sort.collect do |string, v|
      fret, note = v.map.to_a.pop

      n = if last_note
        low_to_high_distance(@key, note)
      else
        0
      end

      if last_note && note == @key
        octave += 12
      end
      last_note = note

      n + octave
    end

    super({
      :notes => midi_notes,
      :instrument => 'Acoustic Guitar (steel)',
      :strum => true
    }.merge(options))
  end

  def to_image(options = {})
    options = {
      :lefty => false
    }.merge options

    min_fret, max_fret = @min_fret, @max_fret

    # We want to make images with only a single fret easier to read, so
    # bump them up by 1 where necessary.
    max_fret += 1 if min_fret == max_fret

    width_offset = 20
    width = (@tuning.length + 2) * width_offset
    height = (max_fret - min_fret + 2) * 40
    image = GD2::Image::IndexedColor.new width, height

    image_tuning = @tuning_notes.dup
    image_tuning.reverse! if options[:lefty]

    image.draw do |pen|
      # set up background with transparency...
      pen.color = image.palette.resolve(COLORS[:background])

      # black outline...
      pen.color = image.palette.resolve(COLORS[:black])
      pen.rectangle(0, 0, width - 4, height - 4)

      # white background...
      pen.color = image.palette.resolve(COLORS[:white])
      pen.rectangle(1, 1, width - 5, height - 5, true)

      # drop shadow...
      pen.color = image.palette.resolve(COLORS[:gray])
      pen.thickness = 4
      pen.line(4, height - 1, width, height - 1)
      pen.line(width - 1, 4, width - 1, height)

      pen.rectangle_with_gradient(
        24,
        22,
        24 + width_offset * image_tuning.length,
        height - 8, {
          :from_color => COLORS[:fretboard][:from],
          :to_color => COLORS[:fretboard][:to]
        }
      )

      # back to default colours
      pen.color = image.palette.resolve(COLORS[:white])

      pen.font = GD2::Font::TrueType[FONT_PATH, 10]
      pen.thickness = 2

      # the frets
      ((min_fret)..(max_fret)).each_with_index do |f, i|
        pen.color = image.palette.resolve(COLORS[:black])
        pen.move_to(6, 70 + 30 * i)
        pen.text f.to_s.rjust(2)
        pen.color = image.palette.resolve(COLORS[:frets])
        pen.line(10, 76 + 30 * i, width - 10, 76 + 30 * i)
      end

      # the strings
      pen.color = image.palette.resolve(COLORS[:strings])
      image_tuning.each_with_index do |n, s|
        x = 34 + width_offset * s
        pen.line(x, 26, x, height - 8)
      end

      pen.color = image.palette.resolve(COLORS[:black])
      image_tuning.each_with_index do |n, s|
        x = if n.length == 2
          25 + width_offset * s
        else
          29 + width_offset * s
        end
        pen.move_to(x, 20)
        pen.text n
      end

      image_tuning.each_with_index do |n, s|
        m = if options[:lefty]
          image_tuning.length - s - 1
        else
          s
        end

        if @fingering[s]
          n = @fingering[s].values.first.to_s
          r = @fingering[s].keys.first
          y_offset = (r - @min_fret + 1) * 30
          x = if n.length == 2
            25 + width_offset * m
          else
            29 + width_offset * m
          end

          klass = interval_to_html_class(@intervals, n).to_sym
          pen.color = image.palette.resolve(COLORS[klass][:bg])
          pen.circle(34 + width_offset * m, 34, 20, true)
          pen.move_to(30 + width_offset * m, 40)
          pen.color = image.palette.resolve(COLORS[klass][:fg])
          pen.move_to(x, 40)
          pen.text n

          next if (@fingering[s].keys.first - @min_fret + 1) <= 0

          pen.color = image.palette.resolve(COLORS[klass][:bg])
          pen.circle(34 + width_offset * m, 34 + y_offset, 20, true)
          pen.move_to(30 + width_offset * m, 40 + y_offset)
          pen.color = image.palette.resolve(COLORS[klass][:fg])
          pen.move_to(x, 40 + y_offset)
          pen.text n
        else
          pen.color = image.palette.resolve(COLORS[:black])
          pen.circle(34 + 20 * m, 34, 20, true)
          pen.move_to(30 + 20 * m, 40)
          pen.color = image.palette.resolve(COLORS[:white])
          pen.text 'X'
        end
      end
    end

    image
  end

  def to_png(options = {})
    self.to_image(options).png
  end

  def to_param
    self.to_a.sort_by(&:first).collect { |k, v| "#{k} #{v.to_a.join}" }.join(' ')
  end

  def ==(other)
    self.to_s == other.to_s
  end

  protected

  def parse_fingering(fingering)
    if fingering.is_a?(String) && fingering.upcase =~ /^(([0-9]+)\s([0-9]+)([A-G]#?)\s?)+$/
      retval = Hash.new
      fingering.upcase.scan(/([0-9]+)\s([0-9]+)([A-G]#?)/) do |memo, n|
        retval[$1.to_i] = { $2.to_i => $3 }
      end
      retval
    elsif fingering.is_a?(Hash)
      fingering
    else
      raise BadFingering.new(fingering)
    end
  end
end

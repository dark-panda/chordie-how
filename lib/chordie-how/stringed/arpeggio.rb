# encoding: UTF-8

require 'chordie-how/stringed/scale_base'

# The similar to the Scale class, but only outputs arbitrary notes rather
# than scales.
class ChordieHow::Stringed::Arpeggio
  include ChordieHow::Stringed::ScaleBase

  attr_reader :key, :type, :notes, :intervals

  # * key is the key of the chord, from NOTES.
  # * type is a Symbol representing a chord type from CHORD_TYPES
  #   or an Array of intervals.
  #
  # Options:
  #
  # * :tuning - the tuning to use for the open strings, either as a
  #   Symbol representing an entry in TUNINGS or as an Array of
  #   intervals. The default is the standard for a six-string guitar
  #   (EADGBE).
  def initialize(key, type, options = {})
    options = {
      :tuning => :guitar_standard
    }.merge options

    @key = key
    @type = type
    @tuning = find_open_strings(options[:tuning])
    @notes = find_chord_notes(@key, @type)
    @intervals = find_intervals(@key, @notes)
  end
end

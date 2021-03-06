# encoding: UTF-8

require 'chordie-how/stringed/scale_base'

# The Scale class, unlike the Chord class, should be accessed directly
# since figuring out the note positions on the fretboard is far less
# involved than with a chord.
class ChordieHow::Stringed::Scale
  include ChordieHow::Stringed::ScaleBase

  attr_reader :key, :pattern, :notes, :intervals

  # * key is the key of the chord, from NOTES.
  # * pattern is a Symbol representing a pattern from SCALE_PATTERNS
  #   or an Array representing the same.
  #
  # Options:
  #
  # * :tuning - the tuning to use for the open strings, either as a
  #   Symbol representing an entry in TUNINGS or as an Array of
  #   intervals. The default is the standard for a six-string guitar
  #   (EADGBE).
  def initialize(key, pattern = :major, options = {})
    options = {
      :tuning => :guitar_standard
    }.merge options

    @key = key
    @pattern = find_scale_pattern(pattern)
    @tuning = find_open_strings(options[:tuning])
    @notes = find_scale_notes(@key, @pattern)
    @intervals = find_intervals(@key, @notes)
  end
end

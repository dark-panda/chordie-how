# encoding: UTF-8

require 'chordie-how/keyboard/diagrams'

class ChordieHow::Keyboard::Scale
  include ChordieHow::Keyboard::Diagrams

  attr_reader :key, :pattern, :notes, :intervals

  def initialize key, pattern = :major, options = {}
    options = {
    }.merge options

    @key = key
    @pattern = find_scale_pattern(pattern)
    @notes = find_scale_notes(@key, @pattern)
    @intervals = find_intervals(@key, @notes)
  end
end

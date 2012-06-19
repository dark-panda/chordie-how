# encoding: UTF-8

require 'music/keyboard/diagrams'

class Music::Keyboard::Scale
  include Music::Keyboard::Diagrams

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


$: << File.dirname(__FILE__)
require 'test_helper'

class UtilsDowncaseTest < Test::Unit::TestCase
  include TestHelper
  include Music::Utils

  def test_find_scale_pattern
    assert_equal(%w{ w w h w w w h }, find_scale_pattern(:major))

    assert_equal(%w{ w w h w w w h }, %w{ w w h w w w h })

    assert_equal(%w{ w w h w w w h },
      find_scale_pattern(Music::Constants::SCALE_PATTERNS[:major])
    )
  end

  def test_find_chord_type
    assert_equal([ 0, 4, 7 ], find_chord_type(:major))

    assert_equal([ 0, 4, 7 ], [ 0, 4, 7 ])

    assert_equal([ 0, 4, 7 ],
      find_chord_type(Music::Constants::CHORD_TYPES[:major])
    )
  end

  def test_find_chord_name
    assert_equal('major', find_chord_name(:major))
    assert_equal('major', find_chord_name('major'))
  end

  def test_find_scale_name
    assert_equal('major', find_scale_name(:major))
    assert_equal('major', find_scale_name('major'))
  end

  def test_find_scale_notes
    assert_equal(%w{ C D E F G A B }, find_scale_notes('c', :major))
  end

  def test_find_scale_intervals
    assert_equal([ 0, 2, 4, 5, 7, 9, 11, 12 ], find_scale_intervals(:major))
  end

  def test_find_note_from_char
    assert_equal(3, find_note_from_char('c'))
  end

  def test_find_note_from_index
    assert_equal('C', find_note_from_index(3))
    assert_equal('C', find_note_from_index(15))
    assert_equal('C', find_note_from_index(-21))
  end

  def test_find_chord_notes
    assert_equal(%w{ C E G }, find_chord_notes('c', :major))
  end

  def test_interval_or_note_to_interval
    assert_equal(4, interval_or_note_to_interval('c', 'e'))
    assert_equal(4, interval_or_note_to_interval('c', 4))
  end

  def test_find_intervals
    assert_equal([
        ["C", "tonic"],
        ["C#", "minor second"],
        ["D", "major second"],
        ["D#", "minor third"],
        ["E", "major third"],
        ["F", "fourth"],
        ["F#", "diminished fifth"],
        ["G", "perfect fifth"],
        ["G#", "minor sixth"],
        ["A", "major sixth"],
        ["A#", "minor seventh"],
        ["B", "major seventh"]
      ],
      find_intervals('c')
    )

    assert_equal([["E", "major third"], ["F", "fourth"], ["F#", "diminished fifth"]],
      find_intervals('c', [ 4, 5, 6 ])
    )
  end

  def test_find_symbols
    assert_equal([
        ["C", "I"],
        ["C#", "ii"],
        ["D", "II"],
        ["D#", "iii"],
        ["E", "III"],
        ["F", "IV"],
        ["F#", "IV+ or V"],
        ["G", "V"],
        ["G#", "V+ or vi"],
        ["A", "VI or vii\302\272"],
        ["A#", "vii"],
        ["B", "VII"]
      ],
      find_symbols('c')
    )

    assert_equal([["E", "III"], ["F", "IV"], ["F#", "IV+ or V"]],
      find_symbols('c', [ 4, 5, 6 ])
    )
  end

  def test_find_single_symbols
    assert_equal([
        ["C", "I"],
        ["C#", "ii"],
        ["D", "II"],
        ["D#", "iii"],
        ["E", "III"],
        ["F", "IV"],
        ["F#", "IV+"],
        ["G", "V"],
        ["G#", "vi"],
        ["A", "VI"],
        ["A#", "vii"],
        ["B", "VII"]
      ],
      find_single_symbols('c')
    )

    assert_equal([["E", "III"], ["F", "IV"], ["F#", "IV+"]],
      find_single_symbols('c', [ 4, 5, 6 ])
    )
  end

  def test_find_degrees
    assert_equal([
        ["C", "tonic"],
        ["C#", "super tonic"],
        ["D", "super tonic"],
        ["D#", "mediant"],
        ["E", "mediant"],
        ["F", "subdominant"],
        ["F#", "tritone"],
        ["G", "dominant"],
        ["G#", "sub mediant"],
        ["A", "sub mediant"],
        ["A#", "sub tonic"],
        ["B", "leading note"]
      ],
      find_degrees('c')
    )

    assert_equal([["E", "mediant"], ["F", "subdominant"], ["F#", "tritone"]],
      find_degrees('c', [ 4, 5, 6 ])
    )
  end

  def test_find_characteristics
    assert_equal([
        ["C", "open consonance"],
        ["C#", "sharp dissonance"],
        ["D", "mild dissonance"],
        ["D#", "soft consonance"],
        ["E", "soft consonance"],
        ["F", "consonance or dissonance"],
        ["F#", "neutral or restless"],
        ["G", "open consonance"],
        ["G#", "soft consonance"],
        ["A", "soft consonance"],
        ["A#", "mild dissonance"],
        ["B", "sharp dissonance"]
      ],
      find_characteristics('c')
    )

    assert_equal([
        ["E", "soft consonance"],
        ["F", "consonance or dissonance"],
        ["F#", "neutral or restless"]
      ],
      find_characteristics('c', [ 4, 5, 6 ])
    )
  end

  def test_interval_to_html_class
    intervals = find_intervals('c')
    assert_equal('tonic', interval_to_html_class(intervals, 'c'))
    assert_equal('major-second', interval_to_html_class(intervals, 'd'))
  end

  def test_interval_class_to_style
    assert_equal("background-color: #AA1919; color: white; font-weight: bold;", interval_class_to_style('tonic'))
    assert_equal("background-color: #005F00; color: white; font-weight: bold;", interval_class_to_style('major-second'))
  end

  def test_interval_to_html_style
    intervals = find_intervals('c')
    assert_equal("background-color: #AA1919; color: white; font-weight: bold;", interval_to_html_style(intervals, 'c'))
    assert_equal("background-color: #005F00; color: white; font-weight: bold;", interval_to_html_style(intervals, 'd'))
  end

  def test_shortest_distance
    assert_equal(-3, shortest_distance(4, 7))
    assert_equal(-1, shortest_distance(4, 17))
    assert_equal(-2, shortest_distance('c', 'd'))
    assert_equal(3, shortest_distance('c', 'a'))
  end

  def test_low_to_high_distance
    assert_equal(3, low_to_high_distance(4, 7))
    assert_equal(13, low_to_high_distance(4, 17))
    assert_equal(2, low_to_high_distance('c', 'd'))
    assert_equal(9, low_to_high_distance('c', 'a'))
  end

  def test_find_chords_from_notes
    assert_equal([["C", :sixth], ["A", :min_7]], find_chords_from_notes(%w{ c e g a }))
  end

  def test_find_scales_from_notes
    assert_equal({
      "A" => [:natural_minor, :aeolian],
      "B" => [:locrian],
      "C" => [:major, :ionian],
      "D" => [:dorian],
      "E" => [:phrygian],
      "F" => [:lydian],
      "G" => [:mixolydian]
    }, find_scales_from_notes(%w{ c d e f g a b }))

    assert_equal({
      "A" => [:harmonic_minor],
      "E" => [:altered, :spanish_gypsy],
      "F" => [:melodic_minor]
    }, find_scales_from_notes(%w{ c d e f g# }))
  end
end

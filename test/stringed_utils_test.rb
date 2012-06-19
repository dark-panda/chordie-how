
$: << File.dirname(__FILE__)
require 'test_helper'

class StringedUtilsTest < Test::Unit::TestCase
  include TestHelper
  include Music::Stringed::Utils

  C_MAJOR_STANDARD = YAML.load(File.read(File.join(File.dirname(__FILE__), *%w{resources stringed c_major_standard.yml})))
  C_MAJOR_ABCDEFG = YAML.load(File.read(File.join(File.dirname(__FILE__), *%w{resources stringed c_major_abcdefg.yml})))

  def test_have_limit
    assert(!have_limit?(nil))
    assert(have_limit?(10))
    assert(have_limit?('10'))
    assert(!have_limit?('foo'))
  end

  def test_find_open_strings
    assert_equal([7, 0, 5, 10, 2, 7], find_open_strings(:guitar_standard))
    assert_equal([9, 2, 7, 0, 4, 9], find_open_strings(:guitar_standard, 2))

    assert_equal([7, 0, 5, 10, 2, 7], find_open_strings('guitar_standard'))
    assert_equal([9, 2, 7, 0, 4, 9], find_open_strings('guitar_standard', 2))

    assert_equal([7, 0, 5, 10, 2, 7], find_open_strings(%w{ E A D G B E }))
    assert_equal([9, 2, 7, 0, 4, 9], find_open_strings(%w{ E A D G B E }, 2))
  end

  def test_find_notes
    assert_equal(%w{ E A }, find_notes([7, 0]))
    assert_equal(%w{ F# B }, find_notes([7, 0], 2))

    assert_equal('E', find_notes(7))
    assert_equal('F#', find_notes(7, 2))
  end

  def test_find_chords_c_major_standard
    c_major_generated = find_chords('C', :major)

    assert_equal(C_MAJOR_STANDARD[0].fingering, c_major_generated[0].fingering)
    assert_equal(C_MAJOR_STANDARD[10].fingering, c_major_generated[10].fingering)
    assert_equal(C_MAJOR_STANDARD.last.fingering, c_major_generated.last.fingering)
  end

  def test_find_chords_c_major_abcdefg
    c_major_generated = find_chords('C', :major, :tuning => %w{ A B C D E F G })

    assert_equal(C_MAJOR_ABCDEFG[0].fingering, c_major_generated[0].fingering)
    assert_equal(C_MAJOR_ABCDEFG[10].fingering, c_major_generated[10].fingering)
    assert_equal(C_MAJOR_ABCDEFG.last.fingering, c_major_generated.last.fingering)
  end

  def test_refine_chord
    without_inversion = find_chords('C', :major, :limit => 1).first.fingering
    with_inversion = find_chords('C', :major, :inversions => true, :limit => 1).first.fingering

    refine_chord('C', with_inversion, %w{ C E G })

    assert_equal(without_inversion, with_inversion)
  end

  def test_check_chord
    with_inversion = find_chords('C', :major, :inversions => true, :limit => 1).first.fingering

    assert(check_chord(with_inversion, %w{ C E G }))
    assert(!check_chord(with_inversion, %w{ D F# A }))
  end
end

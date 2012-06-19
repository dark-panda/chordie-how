# encoding: UTF-8

$: << File.dirname(__FILE__)
require 'test_helper'

class StringedChordTest < Test::Unit::TestCase
  include TestHelper
  include Music::Utils

  C_MAJOR_STANDARD = Music::Stringed::Chord.new(
    'C',
    '5 0E 1 3C 2 2E 3 0G 4 1C'
  )
  D_MINOR_DADGAD = Music::Stringed::Chord.new(
    'D',
    '5 3F 0 0D 1 0A 2 0D 3 2A 4 0A',
    :tuning => :guitar_open_dsus4
  )

  def test_to_html
    assert_equal(
      File.read(
        File.join(File.dirname(__FILE__), %w{ resources stringed c_major_standard.html })
      ),
      C_MAJOR_STANDARD.to_html
    )
  end

  def test_to_txt
    assert_equal([
      "    E  A  D  G  B  E  ",
      "    x  C  E  G  C  E  ",
      " 1              o     ",
      " 2        o           ",
      " 3     o              \n"
    ].join("\n"), C_MAJOR_STANDARD.to_txt)
  end

  def test_to_s
    assert_equal('x 3 2 0 1 0', C_MAJOR_STANDARD.to_s)
  end

  def test_to_a
    assert_equal([
      [ 5, { 0 => "E" } ],
      [ 1, { 3 => "C" } ],
      [ 2, { 2 => "E" } ],
      [ 3, { 0 => "G" } ],
      [ 4, { 1 => "C" } ]
    ], C_MAJOR_STANDARD.to_a)
  end

  def test_to_h
    assert_equal({
      5 => { 0 => "E" },
      1 => { 3 => "C" },
      2 => { 2 => "E" },
      3 => { 0 => "G" },
      4 => { 1 => "C" }
    }, C_MAJOR_STANDARD.to_h)
  end

  def test_to_midi
    # to_midi test not implemented yet
  end

  def test_to_image
    # to_image test not implemented yet
  end

  def test_to_png
    # to_png test not implemented yet
  end
end

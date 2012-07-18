# encoding: UTF-8

require 'chordie-how/utils'
require 'chordie-how/stringed/chord'
require 'chordie-how/stringed/scale'

module ChordieHow

  # This module deals with stringed instruments like guitars, basses,
  # ukuleles, etc. Generally speaking, it should more or less work for any
  # bowed or strummed/plucked instruments within reason. (Harps, sitars and
  # the like excepted. Actually maybe a sitar would work, I don't know.)
  module Stringed
    include ChordieHow::Utils

    class StringedException < ChordieHowException; end

    class BadFingering < StringedException
      def initialize(fingering, msg = nil)
        super("Bad fingering: #{fingering.inspect} #{msg}")
      end
    end
  end
end

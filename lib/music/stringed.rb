
require 'music/utils'
require 'music/stringed/chord'
require 'music/stringed/scale'

module Music

  # This module deals with stringed instruments like guitars, basses,
  # ukuleles, etc. Generally speaking, it should more or less work for any
  # bowed or strummed/plucked instruments within reason. (Harps, sitars and
  # the like excepted. Actually maybe a sitar would work, I don't know.)
  module Stringed
    include Music::Utils

    class StringedException < MusicException; end

    class BadFingering < StringedException
      def initialize(fingering, msg = nil)
        super("Bad fingering: #{fingering.inspect} #{msg}")
      end
    end
  end
end

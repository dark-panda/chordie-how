# encoding: UTF-8

# The Music module holds some basic methods and constants that we use to
# figure out notes and such.
module Music
  class MusicException < RuntimeError; end
  class BadScalePattern < MusicException; end

  class BadChordType < MusicException
    def initialize(chord_type, msg = nil)
      super("Bad chord type: #{chord_type} #{msg}")
    end
  end

  class BadScaleType < MusicException
    def initialize(scale_type, msg = nil)
      super("Bad scale type: #{scale_type} #{msg}")
    end
  end

  class BadIntervalName < MusicException
    def initialize(interval, msg = nil)
      super("Bad interval name: #{interval} #{msg}")
    end
  end

  class BadNote < MusicException
    def initialize(note, msg = nil)
      super("Bad note: #{note} #{msg}")
    end
  end

  class BadTuning < MusicException
    def initialize(tuning, msg = nil)
      super("Bad tuning: #{tuning} #{msg}")
    end
  end
end

require 'music/constants'
require 'music/stringed'
require 'music/keyboard'
require 'music/harmonica'


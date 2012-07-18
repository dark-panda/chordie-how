# encoding: UTF-8

# The ChordieHow module holds some basic methods and constants that we use to
# figure out notes and such.
module ChordieHow
  class ChordieHowException < RuntimeError; end
  class BadScalePattern < ChordieHowException; end

  class BadChordType < ChordieHowException
    def initialize(chord_type, msg = nil)
      super("Bad chord type: #{chord_type} #{msg}")
    end
  end

  class BadScaleType < ChordieHowException
    def initialize(scale_type, msg = nil)
      super("Bad scale type: #{scale_type} #{msg}")
    end
  end

  class BadIntervalName < ChordieHowException
    def initialize(interval, msg = nil)
      super("Bad interval name: #{interval} #{msg}")
    end
  end

  class BadNote < ChordieHowException
    def initialize(note, msg = nil)
      super("Bad note: #{note} #{msg}")
    end
  end

  class BadTuning < ChordieHowException
    def initialize(tuning, msg = nil)
      super("Bad tuning: #{tuning} #{msg}")
    end
  end
end

require 'chordie-how/constants'
require 'chordie-how/stringed'
require 'chordie-how/keyboard'
require 'chordie-how/harmonica'


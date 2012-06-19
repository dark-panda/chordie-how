
module Music
  module Constants
    # Standard notes from Western music. We always use the sharps rather
    # than flats to simplify things.
    NOTES = %w{ A A# B C C# D D# E F F# G G# }.freeze

    # The scale patterns we can use.
    #
    # * w - whole step
    # * h - half step
    # * wh - whole step and a half
    # * ww - two whole steps
    SCALE_PATTERNS = {
      :major => {
        :name => 'major',
        :pattern => %w{ w w h w w w h }
      },

      :natural_minor => {
        :name => 'natural minor',
        :pattern => %w{ w h w w h w w }
      },

      :harmonic_minor => {
        :name => 'harmonic minor',
        :pattern => %w{ w h w w h wh h }
      },

      :melodic_minor => {
        :name => 'melodic minor',
        :pattern => %w{ w h w w w w h }
      },

      :major_pentatonic => {
        :name => 'major pentatonic',
        :pattern => %w{ w w wh w wh }
      },

      :minor_pentatonic => {
        :name => 'minor pentatonic',
        :pattern => %w{ wh w w wh w }
      },

      :blues => {
        :name => 'blues',
        :pattern => %w{ wh w h h wh w }
      },

      :octatonic_w_h => {
        :name => 'octatonic (w-h)',
        :pattern => %w{ w h w h w h w h }
      },

      :octatonic_h_w => {
        :name => 'octatonic (h-w)',
        :pattern => %w{ h w h w h w h w }
      },

      :altered => {
        :name => 'altered',
        :pattern => %w{ h w h w h h w w }
      },

      :chinese => {
        :name => 'Chinese',
        :pattern => %w{ ww w h ww h }
      },

      :egyptian => {
        :name => 'Egyptian',
        :pattern => %w{ w wh w wh w }
      },

      :spanish_gypsy => {
        :name => 'Spanish Gypsy',
        :pattern => %w{ h wh h w h w w }
      },

      :ionian => {
        :name => 'mode - ionian',
        :pattern => %w{ w w h w w w h }
      },

      :dorian => {
        :name => 'mode - dorian',
        :pattern => %w{ w h w w w h w }
      },

      :phrygian => {
        :name => 'mode - phrygian',
        :pattern => %w{ h w w w h w w }
      },

      :lydian => {
        :name => 'mode - lydian',
        :pattern => %w{ w w w h w w h }
      },

      :mixolydian => {
        :name => 'mode - mixolydian',
        :pattern => %w{ w w h w w h w }
      },

      :aeolian => {
        :name => 'mode - aeolian',
        :pattern => %w{ w h w w h w w }
      },

      :locrian => {
        :name => 'mode - locrian',
        :pattern => %w{ h w w h w w w }
      }
    }.freeze


    # Numbers indicate distance away from the root, i.e...
    #
    # 0 -- root/tonic
    # 1 -- minor second
    # 2 -- major second
    # 3 -- minor third
    # 4 -- major third
    # 5 -- fourth
    # 6 -- diminished fifth
    # 7 -- perfect fifth
    # 8 -- minor sixth
    # 9 -- major sixth
    # 10 -- minor seventh
    # 11 -- major seventh
    # 12 -- octave (not really used)
    # 13 -- minor ninth
    # 14 -- major ninth
    # 17 -- eleventh
    # 21 -- thirteenth
    CHORD_TYPES = {
      :sus2 => {
        :name => 'sus2',
        :intervals => [ 0, 2, 7 ]
      },

      :sus4 => {
        :name => 'sus4',
        :intervals => [ 0, 5, 7 ]
      },

      :diminished => {
        :name => 'dim',
        :intervals => [ 0, 3, 6 ]
      },

      :minor => {
        :name => 'minor',
        :intervals => [ 0, 3, 7 ]
      },

      :major => {
        :name => 'major',
        :intervals => [ 0, 4, 7 ]
      },

      :augmented => {
        :name => 'aug',
        :intervals => [ 0, 4, 8 ]
      },

      :min_add2 => {
        :name => 'min add2',
        :intervals => [ 0, 2, 3, 7 ]
      },

      :add2 => {
        :name => 'add2',
        :intervals => [ 0, 2, 4, 7 ]
      },

      :'7_sus2' => {
        :name => '7 sus2',
        :intervals => [ 0, 2, 7, 10 ]
      },

      :min_add4 => {
        :name => 'min add4',
        :intervals => [ 0, 3, 5, 7 ]
      },

      :dim7 => {
        :name => 'dim7',
        :intervals => [ 0, 3, 6, 9 ]
      },

      :min_7b5 => {
        :name => 'min 7b5',
        :intervals => [ 0, 3, 6, 10 ]
      },

      :min_add9 => {
        :name => 'min add9',
        :intervals => [ 0, 3, 7, 14 ]
      },

      :min_6 => {
        :name => 'min 6',
        :intervals => [ 0, 3, 7, 9 ]
      },

      :min_7 => {
        :name => 'min 7',
        :intervals => [ 0, 3, 7, 10 ]
      },

      :min_maj7 => {
        :name => 'min maj 7',
        :intervals => [ 0, 3, 7, 11 ]
      },

      :maj_7s5 => {
        :name => 'maj 7#5',
        :intervals => [ 0, 3, 8, 10 ]
      },

      :add4 => {
        :name => 'add4',
        :intervals => [ 0, 4, 5, 7 ]
      },

      :'7b5' => {
        :name => '7b5',
        :intervals => [ 0, 4, 6, 10 ]
      },

      :maj_7b5 => {
        :name => 'maj 7b5',
        :intervals => [ 0, 4, 6, 11 ]
      },

      :sixth => {
        :name => '6',
        :intervals => [ 0, 4, 7, 9 ]
      },

      :seventh => {
        :name => '7',
        :intervals => [ 0, 4, 7, 10 ]
      },

      :maj_7 => {
        :name => 'maj 7',
        :intervals => [ 0, 4, 7, 11 ]
      },

      :add9 => {
        :name => 'add9',
        :intervals => [ 0, 4, 7, 2 ]
      },

      :'7s5' => {
        :name => '7#5',
        :intervals => [ 0, 4, 8, 10 ]
      },

      :maj_7s5 => {
        :name => 'maj 7#5',
        :intervals => [ 0, 4, 8, 11 ]
      },

      :'7_sus4' => {
        :name => '7 sus4',
        :intervals => [ 0, 5, 7, 10 ]
      },

      :min_add2_add4 => {
        :name => 'min add2 add4',
        :intervals => [ 0, 2, 3, 5, 7 ]
      },

      :add2_add4 => {
        :name => 'add2 add4',
        :intervals => [ 0, 2, 4, 5, 7 ]
      },

      :min_7_add4 => {
        :name => 'min 7 add4',
        :intervals => [ 0, 3, 5, 7, 10 ]
      },

      :min_6_7 => {
        :name => 'min 6/7',
        :intervals => [ 0, 3, 7, 9, 10 ]
      },

      :min_6_9 => {
        :name => 'min 6/9',
        :intervals => [ 0, 3, 7, 9, 14 ]
      },

      :min_9 => {
        :name => 'min 9',
        :intervals => [ 0, 3, 7, 10, 14 ]
      },

      :min_9_maj_9 => {
        :name => 'min maj 9',
        :intervals => [ 0, 3, 7, 11, 14 ]
      },

      :'7_add4' => {
        :name => '7 add4',
        :intervals => [ 0, 4, 5, 7, 10 ]
      },

      :'9b5' => {
        :name => '9b5',
        :intervals => [ 0, 4, 6, 10, 14 ]
      },

      :'6_7' => {
        :name => '6/7',
        :intervals => [ 0, 4, 7, 9, 10 ]
      },

      :maj_6_7 => {
        :name => 'maj 6/7',
        :intervals => [ 0, 4, 7, 9, 11 ]
      },

      :'6_9' => {
        :name => '6/9',
        :intervals => [ 0, 4, 7, 9, 14 ]
      },

      :'7b9' => {
        :name => '7b9',
        :intervals => [ 0, 4, 7, 10, 13 ]
      },

      :ninth => {
        :name => '9',
        :intervals => [ 0, 4, 7, 10, 14 ]
      },

      :'7s9' => {
        :name => '7#9',
        :intervals => [ 0, 4, 7, 10, 15 ]
      },

      :maj_9 => {
        :name => 'maj 9',
        :intervals => [ 0, 4, 7, 11, 14 ]
      },

      :'9_sus4' => {
        :name => '9 sus4',
        :intervals => [ 0, 5, 7, 10, 14 ]
      },

      :min_11 => {
        :name => 'min 11',
        :intervals => [ 0, 3, 7, 10, 14, 17 ]
      },

      :eleventh => {
        :name => '11',
        :intervals => [ 0, 4, 7, 10, 14, 17 ]
      },

      :maj_11 => {
        :name => 'maj 11',
        :intervals => [ 0, 4, 7, 11, 14, 17 ]
      },

      :fifth => {
        :name => 'fifth (power chord)',
        :intervals => [ 0, 7 ]
      },

      :half_diminished => {
        :name => 'half diminished',
        :intervals => [ 0, 3, 6, 10 ]
      },

      :maj_7s4 => {
        :name => 'maj 7#4',
        :intervals => [ 0, 4, 6, 7, 11 ]
      },

      :min_13 => {
        :name => 'min 13',
        :intervals => [ 0, 3, 7, 10, 14, 17, 21 ]
      },

      :thirteenth => {
        :name => '13',
        :intervals => [ 0, 4, 7, 10, 14, 17, 21 ]
      },

      :maj_13 => {
        :name => 'maj 13',
        :intervals => [ 0, 4, 7, 11, 14, 17, 21 ]
      }
    }.freeze

    INTERVAL_CSS_STYLES = {
      :tonic => {
        'background-color' => '#AA1919',
        'font-weight' => 'bold',
        'color' => 'white'
      },

      :'minor-second' => {
        'background-color' => '#00C900',
        'font-weight' => 'bold',
      },

      :'major-second' => {
        'background-color' => '#005F00',
        'font-weight' => 'bold',
        'color' => 'white'
      },

      :'minor-third' => {
        'background-color' => '#CA90FF',
        'font-weight' => 'bold',
      },

      :'major-third' => {
        'background-color' => '#9000FF',
        'font-weight' => 'bold',
        'color' => 'white'
      },

      :fourth => {
        'background-color' => '#FFDC00',
        'font-weight' => 'bold',
      },

      :'diminished-fifth' => {
        'background-color' => '#FFC990',
        'font-weight' => 'bold',
      },

      :'perfect-fifth' => {
        'background-color' => '#FF8E00',
        'font-weight' => 'bold',
        'color' => 'white'
      },

      :'minor-sixth' => {
        'background-color' => '#B5E3E5',
        'font-weight' => 'bold',
      },

      :'major-sixth' => {
        'background-color' => '#00B4BE',
        'font-weight' => 'bold',
        'color' => 'white'
      },

      :'minor-seventh' => {
        'background-color' => '#73A2D7',
        'font-weight' => 'bold',
      },

      :'major-seventh' => {
        'background-color' => '#0069BA',
        'font-weight' => 'bold',
        'color' => 'white'
      },

      :note => {
        'color' => 'white',
        'background-color' => 'gray',
        'font-weight' => ' bold'
      },

      :muted => {
        'background-color' => 'black',
        'font-weight' => 'bold',
        'color' => 'white'
      }
    }.freeze
  end
end

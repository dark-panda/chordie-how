
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
		CHORD_TYPES = {
			:major => {
				:name => 'major',
				:intervals => [ 0, 4, 7 ]
			},

			:minor => {
				:name => 'minor',
				:intervals => [ 0, 3, 7 ]
			},

			:seventh => {
				:name => 'seventh',
				:intervals => [ 0, 4, 7, 10 ]
			},

			:maj7 => {
				:name => 'maj7',
				:intervals => [ 0, 4, 7, 11 ]
			},

			:min7 => {
				:name => 'min7',
				:intervals => [ 0, 3, 7, 10 ]
			},

			:sus4 => {
				:name => 'sus4',
				:intervals => [ 0, 5, 7 ]
			},

			:sus2 => {
				:name => 'sus2',
				:intervals => [ 0, 2, 7 ]
			},

			:sixth => {
				:name => 'sixth',
				:intervals => [ 0, 4, 7, 9 ]
			},

			:min6 => {
				:name => 'min6',
				:intervals => [ 0, 3, 7, 9 ]
			},

			:fifth => {
				:name => 'fifth (power chord)',
				:intervals => [ 0, 7 ]
			},

			:ninth => {
				:name => 'ninth',
				:intervals => [ 0, 4, 7, 10, 2 ]
			},

			:maj9 => {
				:name => 'maj9',
				:intervals => [ 0, 4, 7, 11, 2 ]
			},

			:min9 => {
				:name => 'min9',
				:intervals => [ 0, 3, 7, 10, 2 ]
			},

			:add9 => {
				:name => 'add9',
				:intervals => [ 0, 4, 7, 2 ]
			},

			:eleventh => {
				:name => 'eleventh',
				:intervals => [ 0, 4, 7, 10, 2, 5 ]
			},

			:min11 => {
				:name => 'min11',
				:intervals => [ 0, 3, 7, 10, 2, 5 ]
			},

			:diminished => {
				:name => 'diminished',
				:intervals => [ 0, 3, 6 ]
			},

			:half_diminished => {
				:name => 'half diminished',
				:intervals => [ 0, 3, 6, 10 ]
			},

			:augmented => {
				:name => 'augmented',
				:intervals => [ 0, 4, 8 ]
			},

			:thirteenth => {
				:name => 'thirteenth',
				:intervals => [ 0, 4, 7, 10, 2, 5, 9 ]
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

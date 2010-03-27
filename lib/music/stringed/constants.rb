
module Music
	module Stringed
	module Constants
	# various tunings we can display. For flats, use the corresponding
	# sharp.
	TUNINGS = {
		:standard => {
			:name => 'standard',
			:tuning => [ 'E', 'A', 'D', 'G', 'B', 'E' ]
		},

		:half_step_flat => {
			:name => '1/2 step flat',
			:tuning => [ 'D#', 'G#', 'C#', 'F#', 'A#', 'D#' ]
		},

		:whole_step_flat => {
			:name => '1 whole step flat',
			:tuning => [ 'D', 'G', 'C', 'F', 'A', 'D' ]
		},

		:drop_d => {
			:name => 'drop D',
			:tuning => [ 'D', 'A', 'D', 'G', 'B', 'E' ]
		},

		:drop_c => {
			:name => 'drop C',
			:tuning => [ 'C', 'A', 'D', 'G', 'B', 'E' ]
		},

		:open_c => {
			:name => 'open C',
			:tuning => [ 'C', 'G', 'C', 'G', 'C', 'E' ]
		},

		:open_d => {
			:name => 'open D',
			:tuning => [ 'D', 'A', 'D', 'F#', 'A', 'D' ]
		},

		:open_g => {
			:name => 'open G',
			:tuning => [ 'D', 'G', 'D', 'G', 'B', 'D' ]
		},

		:open_e => {
			:name => 'open E',
			:tuning => [ 'E', 'B', 'E', 'G#', 'B', 'E' ]
		},

		:open_a => {
			:name => 'open A',
			:tuning => [ 'E', 'A', 'E', 'A', 'C#', 'E' ]
		},

		:open_e_minor => {
			:name => 'open E minor',
			:tuning => [ 'E', 'B', 'E', 'G', 'B', 'E' ]
		},

		:d6 => {
			:name => 'D6',
			:tuning => [ 'D', 'A', 'D', 'G', 'B', 'D' ]
		},

		:dmaj7 => {
			:name => 'DMaj7',
			:tuning => [ 'D', 'A', 'D', 'F#', 'A', 'C#' ]
		},

		:d7 => {
			:name => 'D7',
			:tuning => [ 'D', 'A', 'D', 'F#', 'C', 'D' ]
		},

		:dsus=> {
			:name => 'Dsus',
			:tuning => [ 'D', 'A', 'D', 'G', 'A', 'D' ]
		},

		:daddad => {
			:name => 'DADDAD',
			:tuning => [ 'D', 'A', 'D', 'D', 'A', 'D' ]
		},

		:dadd9 => {
			:name => 'Dadd9',
			:tuning => [ 'D', 'A', 'D', 'E', 'A', 'D' ]
		},

		:dsus_6 => {
			:name => 'Dsus+6',
			:tuning => [ 'B', 'G', 'D', 'F#', 'A', 'D' ]
		},

		:double_drop_d => {
			:name => 'double drop D',
			:tuning => [ 'D', 'A', 'D', 'G', 'B', 'D' ]
		},

		:open_d_minor => {
			:name => 'open D minor',
			:tuning => [ 'D', 'A', 'D', 'F', 'A', 'D' ]
		},

		:open_g_minor => {
			:name => 'open G minor',
			:tuning => [ 'D', 'G', 'D', 'G', 'A#', 'D' ]
		},

		:g6 => {
			:name => 'G 6th',
			:tuning => [ 'D', 'G', 'D', 'G', 'B', 'E' ]
		},

		:standard_seven_string => {
			:name => '7 string standard',
			:tuning => [ 'B', 'E', 'A', 'D', 'G', 'B', 'E' ]
		},

		:nst => {
			:name => 'NST (Robert Fripp)',
			:tuning => [ 'C', 'G', 'D', 'A', 'E', 'G' ]
		},

		:standard_mandolin => {
			:name => 'Mandolin (standard)',
			:tuning => [ 'G', 'D', 'A', 'E' ]
		},

		:standard_fiddle => {
			:name => 'Fiddle (standard)',
			:tuning => [ 'G', 'D', 'A', 'E' ]
		},

		:standard_banjo => {
			:name => 'Banjo (standard)',
			:tuning => [ 'G', 'D', 'G', 'B', 'D' ]
		},

		:standard_dorbo => {
			:name => 'Dobro (standard)',
			:tuning => [ 'G', 'B', 'D', 'G', 'B', 'D' ]
		},

		:standard_lute => {
			:name => 'Lute',
			:tuning => [ 'E', 'A', 'D', 'F#', 'B', 'E' ]
		},

		:baritone_fourth => {
			:name => 'Baritone (down a 4th)',
			:tuning => [ 'B', 'E', 'A', 'D', 'F#', 'B' ]
		},

		:baritone_fifth => {
			:name => 'Baritone (down a 5th)',
			:tuning => [ 'A', 'D', 'G', 'C', 'E', 'A' ]
		},

		:bass_four_string => {
			:name => '4-string bass',
			:tuning => [ 'E', 'A', 'D', 'G' ]
		},

		:bass_five_string => {
			:name => '5-string bass',
			:tuning => [ 'B', 'E', 'A', 'D', 'G' ]
		},

		:bass_six_string => {
			:name => '6-string bass',
			:tuning => [ 'B', 'E', 'A', 'D', 'G', 'B' ]
		},

		:perfect_4th => {
			:name => 'perfect 4th',
			:tuning => [ 'E', 'A', 'D', 'G', 'C', 'F' ]
		},

		:c6th_5 => {
			:name => 'C 6th-5',
			:tuning => [ 'C', 'G', 'D', 'F#', 'A', 'D' ]
		},

		:cmaj7 => {
			:name => 'CMaj7',
			:tuning => [ 'C', 'G', 'D', 'G', 'B', 'D' ]
		},

		:cmaj6 => {
			:name => 'Cmaj6',
			:tuning => [ 'C', 'G', 'C', 'G', 'A', 'E' ]
		},

		:c6add9 => {
			:name => 'C6add9',
			:tuning => [ 'C', 'G', 'D', 'G', 'A', 'D' ]
		},

		:tenor_ukulele => {
			:name => 'Tenor Ukulele',
			:tuning => [ 'G', 'C', 'E', 'A' ]
		},

		:baritone_ukulele => {
			:name => 'Baritone Ukulele',
			:tuning => [ 'D', 'G', 'B', 'E' ]
		},

		:soprano_ukulele => {
			:name => 'Soprano Ukulele',
			:tuning => [ 'A', 'D', 'F#', 'B' ]
		}
	}.freeze

	CSS_STYLES = {
		:'table.chord-diagram' => [
			'margin: 10px;',
			'background-color: white;'
		],

		:'table.scale-diagram' => [
			'background-color: white;',
			'margin: 0px auto;',
			'margin-bottom: 10px;'
		],

		:'table.chord-diagram td' => [
			'border: 1px solid #cccccc;',
			'width: 2em;',
			'height: 2em;',
			'text-align: center;',
			'font-size: small;'
		],

		:'table.scale-diagram td' => [
			'border: 1px solid #cccccc;',
			'width: 2em;',
			'height: 2em;',
			'text-align: center;',
			'font-size: small;'
		]
	}.freeze
end
end
end

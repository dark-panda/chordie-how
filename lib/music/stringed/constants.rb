
module Music
	module Stringed
		module Constants
			# various tunings we can display. For flats, use the corresponding
			# sharp.
			TUNINGS = {
				:standard => {
					:name => 'standard',
					:tuning => %w{ E A D G B E }
				},

				:half_step_flat => {
					:name => '1/2 step flat',
					:tuning => %w{ D# G# C# F# A# D# }
				},

				:whole_step_flat => {
					:name => '1 whole step flat',
					:tuning => %w{ D G C F A D }
				},

				:drop_d => {
					:name => 'drop D',
					:tuning => %w{ D A D G B E }
				},

				:drop_c => {
					:name => 'drop C',
					:tuning => %w{ C A D G B E }
				},

				:open_c => {
					:name => 'open C',
					:tuning => %w{ C G C G C E }
				},

				:open_d => {
					:name => 'open D',
					:tuning => %w{ D A D F# A D }
				},

				:open_e => {
					:name => 'open E',
					:tuning => %w{ E B E G# B E }
				},

				:open_g => {
					:name => 'open G',
					:tuning => %w{ D G D G B D }
				},

				:open_a => {
					:name => 'open A',
					:tuning => %w{ E A E A C# E }
				},

				:open_e_minor => {
					:name => 'open E minor',
					:tuning => %w{ E B E G B E }
				},

				:d6 => {
					:name => 'D6',
					:tuning => %w{ D A D G B D }
				},

				:dmaj7 => {
					:name => 'DMaj7',
					:tuning => %w{ D A D F# A C# }
				},

				:d7 => {
					:name => 'D7',
					:tuning => %w{ D A D F# C D }
				},

				:dsus=> {
					:name => 'Dsus',
					:tuning => %w{ D A D G A D }
				},

				:daddad => {
					:name => 'DADDAD',
					:tuning => %w{ D A D D A D }
				},

				:dadd9 => {
					:name => 'Dadd9',
					:tuning => %w{ D A D E A D }
				},

				:dsus_6 => {
					:name => 'Dsus+6',
					:tuning => %w{ B G D F# A D }
				},

				:double_drop_d => {
					:name => 'double drop D',
					:tuning => %w{ D A D G B D }
				},

				:open_d_minor => {
					:name => 'open D minor',
					:tuning => %w{ D A D F A D }
				},

				:open_g_minor => {
					:name => 'open G minor',
					:tuning => %w{ D G D G A# D }
				},

				:g6 => {
					:name => 'G 6th',
					:tuning => %w{ D G D G B E }
				},

				:e9 => {
					:name => 'E9',
					:tuning => %w{ E G# B D F# G# B E }
				},

				:e7 => {
					:name => 'E7',
					:tuning => %W{ B D E G# B E }
				},

				:e6 => {
					:name => 'E6',
					:tuning => %{ E G# B C# E G# }
				},

				:standard_seven_string => {
					:name => '7 string standard',
					:tuning => %w{ B E A D G B E }
				},

				:nst => {
					:name => 'NST (Robert Fripp)',
					:tuning => %w{ C G D A E G }
				},

				:standard_mandolin => {
					:name => 'Mandolin (standard)',
					:tuning => %w{ G D A E }
				},

				:standard_fiddle => {
					:name => 'Fiddle (standard)',
					:tuning => %w{ G D A E }
				},

				:standard_banjo => {
					:name => 'Banjo (standard)',
					:tuning => %w{ G D G B D }
				},

				:standard_dorbo => {
					:name => 'Dobro (standard)',
					:tuning => %w{ G B D G B D }
				},

				:standard_lute => {
					:name => 'Lute',
					:tuning => %w{ E A D F# B E }
				},

				:baritone_fourth => {
					:name => 'Baritone (down a 4th)',
					:tuning => %w{ B E A D F# B }
				},

				:baritone_fifth => {
					:name => 'Baritone (down a 5th)',
					:tuning => %w{ A D G C E A }
				},

				:bass_four_string => {
					:name => '4-string bass',
					:tuning => %w{ E A D G }
				},

				:bass_five_string => {
					:name => '5-string bass',
					:tuning => %w{ B E A D G }
				},

				:bass_six_string => {
					:name => '6-string bass',
					:tuning => %w{ B E A D G B }
				},

				:perfect_4th => {
					:name => 'perfect 4th',
					:tuning => %w{ E A D G C F }
				},

				:c6th_5 => {
					:name => 'C 6th-5',
					:tuning => %w{ C G D F# A D }
				},

				:cmaj7 => {
					:name => 'CMaj7',
					:tuning => %w{ C G D G B D }
				},

				:cmaj6 => {
					:name => 'Cmaj6',
					:tuning => %w{ C G C G A E }
				},

				:c6add9 => {
					:name => 'C6add9',
					:tuning => %w{ C G D G A D }
				},

				:tenor_ukulele => {
					:name => 'Tenor Ukulele',
					:tuning => %w{ G C E A }
				},

				:baritone_ukulele => {
					:name => 'Baritone Ukulele',
					:tuning => %w{ D G B E }
				},

				:soprano_ukulele => {
					:name => 'Soprano Ukulele',
					:tuning => %w{ A D F# B }
				}
			}.freeze

			CSS_STYLES = {
				:'table.chord-diagram' => {
					:'margin' => '10px',
					:'background-color' => 'white'
				},

				:'table.scale-diagram' => {
					:'background-color' => 'white',
					:'margin' => '0px auto',
					:'margin-bottom' => '10px'
				},

				:'table.chord-diagram td' => {
					:'border' => '1px solid #cccccc',
					:'width' => '2em',
					:'height' => '2em',
					:'text-align' => 'center',
					:'font-size' => 'small'
				},

				:'table.scale-diagram td' => {
					'border' => '1px solid #cccccc',
					'width' => '2em',
					'height' => '2em',
					'text-align' => 'center',
					'font-size' => 'small'
				}
			}.freeze
		end
	end
end

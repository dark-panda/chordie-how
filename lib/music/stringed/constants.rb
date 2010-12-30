
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

				:open_a => {
					:name => 'open A',
					:tuning => %w{ E A E A C# E }
				},

				:open_a_2 => {
					:name => 'open A variant',
					:tuning => %w{ E A C# E A E }
				},

				:open_b => {
					:name => 'open B',
					:tuning => %w{ B F# B F# B D# }
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

				:open_f => {
					:name => 'open F',
					:tuning => %w{ F A C F C F }
				},

				:open_g => {
					:name => 'open G',
					:tuning => %w{ D G D G B D }
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
				},

				:asus2 => {
					:name => 'Asus2',
					:tuning => %w{ E A B E A E }
				},

				:asus4 => {
					:name => 'Asus4',
					:tuning => %w{ E A D E A E }
				},

				:c6 => {
					:name => 'C6',
					:tuning => %w{ C A C G C E }
				},

				:open_page => {
					:name => 'open Page',
					:tuning => %w{ D G C G C D }
				},

				:csus2 => {
					:name => 'Csus2',
					:tuning => %w{ C G C G C D }
				},

				:csus4_9 => {
					:name => 'Csus4+9',
					:tuning => %w{ C G C F C D }
				},

				:csus4 => {
					:name => 'Csus4',
					:tuning => %w{ C G C G C F }
				},

				:c15 => {
					:name => 'C15',
					:tuning => %w{ C G D G C D }
				},

				:dsus2 => {
					:name => 'Dsus2',
					:tuning => %w{ D A D E A D }
				},

				:dsus4 => {
					:name => 'Dsus4',
					:tuning => %w{ D A D G A D }
				},

				:esus2 => {
					:name => 'Esus2',
					:tuning => %w{ E A E F# B E }
				},

				:esus4 => {
					:name => 'Esus4',
					:tuning => %w{ E A E A B E }
				},

				:gsus2 => {
					:name => 'Gsus2',
					:tuning => %w{ D G D G A D }
				},

				:gsus4 => {
					:name => 'Gsus4',
					:tuning => %w{ D G D G C D }
				},

				:e_modal => {
					:name => 'E modal',
					:tuning => %w{ E B E E B E }
				},

				:g_modal => {
					:name => 'G modal',
					:tuning => %w{ G G D G B D }
				},

				:b_modal => {
					:name => 'B modal',
					:tuning => %w{ B F# C# F# B D# }
				},

				:c_sharp => {
					:name => 'C#',
					:tuning => %w{ C# F# B E G# C# }
				},

				:terz_tuning => {
					:name => 'Terz tuning',
					:tuning => %w{ G C F A# D G }
				},

				:cross_note_a => {
					:name => 'cross note A',
					:tuning => %w{ E A E A C E }
				},

				:cross_note_a_alt_1 => {
					:name => 'cross note A alt. 1',
					:tuning => %w{ E A C E A E }
				},

				:cross_note_c => {
					:name => 'cross note C',
					:tuning => %w{ C G C G C D# }
				},

				:cross_note_f => {
					:name => 'cross note F',
					:tuning => %w{ F G# C F C F }
				},

				:cross_note_f_alt_1 => {
					:name => 'cross note F alt. 1',
					:tuning => %w{ F C F G# C F }
				},

				:open_dmin7 => {
					:name => 'open Dmin7',
					:tuning => %w{ D A D F A C }
				},

				:open_dmin_add9 => {
					:name => 'open Dmin add9 ',
					:tuning => %w{ D A D F A E }
				},

				:open_emin7 => {
					:name => 'open Emin7',
					:tuning => %w{ E B D G B E }
				},

				:dobro_open_g6 => {
					:name => 'Dobro open G6',
					:tuning => %w{ G B D G B E }
				},

				:open_g7_alt_1 => {
					:name => 'open G7 alt. 1',
					:tuning => %w{ D G D G B F }
				},

				:open_g7_alt_2 => {
					:name => 'open G7 alt. 2',
					:tuning => %w{ D G D F B D }
				},

				:open_g7_alt_3 => {
					:name => 'open G7 alt. 3',
					:tuning => %w{ F G D G B D }
				},

				:open_gmaj7 => {
					:name => 'open Gmaj7',
					:tuning => %w{ D G D F# B D }
				},

				:modal_g7 => {
					:name => 'Modal G7',
					:tuning => %w{ F G D G C D }
				},

				:open_g13 => {
					:name => 'open G13',
					:tuning => %w{ F G D G B E }
				},

				:open_cmin7 => {
					:name => 'open Cmin7',
					:tuning => %w{ C G C G A# D# }
				},

				:open_cmaj7 => {
					:name => 'open Cmaj7',
					:tuning => %w{ C G C G B E }
				},

				:open_c6_9 => {
					:name => 'open C6/9',
					:tuning => %w{ C G C E A C }
				},

				:open_cmaj9 => {
					:name => 'open Cmaj9',
					:tuning => %w{ C G D G B E }
				},

				:csus2add11 => {
					:name => 'Csus2add11',
					:tuning => %w{ C G D F C F }
				},

				:golden_blue => {
					:name => 'Golden Blue',
					:tuning => %w{ C C C C A# F }
				},

				:open_gsus4 => {
					:name => 'open Gsus4',
					:tuning => %w{ D G C G C D }
				},

				:gorac => {
					:name => 'Gorac',
					:tuning => %w{ B G D G A E }
				},

				:strumstick => {
					:name => 'Strumstick',
					:tuning => %w{ G D G }
				},

				:strumstick_grand => {
					:name => 'Strumsick Grand',
					:tuning => %w{ D A D }
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

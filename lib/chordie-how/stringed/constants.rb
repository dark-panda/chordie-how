# encoding: UTF-8

module ChordieHow
  module Stringed
    module Constants
      # various tunings we can display. For flats, use the corresponding
      # sharp.
      TUNINGS = {
        :guitar_standard => {
          :name => 'Guitar standard',
          :tuning => %w{ E A D G B E }
        },

        :guitar_half_step_flat => {
          :name => 'Guitar 1/2 step flat',
          :tuning => %w{ D# G# C# F# A# D# }
        },

        :guitar_whole_step_flat => {
          :name => 'Guiar 1 whole step flat',
          :tuning => %w{ D G C F A D }
        },

        :guitar_drop_d => {
          :name => 'Guitar drop D',
          :tuning => %w{ D A D G B E }
        },

        :guitar_drop_c => {
          :name => 'Guitar drop C',
          :tuning => %w{ C A D G B E }
        },

        :guitar_open_a => {
          :name => 'Guitar open A',
          :tuning => %w{ E A E A C# E }
        },

        :guitar_open_a_2 => {
          :name => 'Guitar open A variant',
          :tuning => %w{ E A C# E A E }
        },

        :guitar_open_b => {
          :name => 'Guitar open B',
          :tuning => %w{ B F# B F# B D# }
        },

        :guitar_open_c => {
          :name => 'guitar open C',
          :tuning => %w{ C G C G C E }
        },

        :guitar_open_c_2 => {
          :name => 'Guitar open C variant',
          :tuning => %w{ C G C E G C }
        },

        :guitar_open_d => {
          :name => 'Guitar open D',
          :tuning => %w{ D A D F# A D }
        },

        :guitar_open_e => {
          :name => 'Guitar open E',
          :tuning => %w{ E B E G# B E }
        },

        :guitar_open_f => {
          :name => 'Guitar open F',
          :tuning => %w{ F A C F C F }
        },

        :guitar_open_g => {
          :name => 'Guitar open G',
          :tuning => %w{ D G D G B D }
        },

        :guitar_open_e_minor => {
          :name => 'Guitar open E minor',
          :tuning => %w{ E B E G B E }
        },

        :guitar_open_d6 => {
          :name => 'Guitar open D6',
          :tuning => %w{ D A D G B D }
        },

        :guitar_open_dmaj7 => {
          :name => 'Guitar open DMaj7',
          :tuning => %w{ D A D F# A C# }
        },

        :guitar_open_d7 => {
          :name => 'Guitar open D7',
          :tuning => %w{ D A D F# C D }
        },

        :guitar_daddad => {
          :name => 'Guitar DADDAD',
          :tuning => %w{ D A D D A D }
        },

        :guitar_open_dadd9 => {
          :name => 'Guitar open Dadd9',
          :tuning => %w{ D A D E A D }
        },

        :guitar_open_dsus_6 => {
          :name => 'Guitar open Dsus+6',
          :tuning => %w{ B G D F# A D }
        },

        :guitar_double_drop_d => {
          :name => 'Guitar double drop D',
          :tuning => %w{ D A D G B D }
        },

        :guitar_open_d_minor => {
          :name => 'Guitar open D minor',
          :tuning => %w{ D A D F A D }
        },

        :guitar_open_g_minor => {
          :name => 'Guitar open G minor',
          :tuning => %w{ D G D G A# D }
        },

        :guitar_open_g6 => {
          :name => 'Guitar open G 6th',
          :tuning => %w{ D G D G B E }
        },

        :guitar_open_e9 => {
          :name => 'Guitar open E9',
          :tuning => %w{ E G# B D F# G# B E }
        },

        :guitar_open_e7 => {
          :name => 'Guitar open E7',
          :tuning => %W{ B D E G# B E }
        },

        :guitar_open_e6 => {
          :name => 'Guitar open E6',
          :tuning => %{ E G# B C# E G# }
        },

        :guitar_standard_seven_string => {
          :name => 'Guitar 7 string standard',
          :tuning => %w{ B E A D G B E }
        },

        :guitar_nst => {
          :name => 'Guitar NST (Robert Fripp)',
          :tuning => %w{ C G D A E G }
        },

        :guitar_wahine_a => {
          :name => 'Guitar A wahine (Amaj7)',
          :tuning => %w{ E A E G# C# E }
        },

        :guitar_wahine_g => {
          :name => 'Guitar Wahine G (Gmaj7)',
          :tuning => %w{ D G D F# B D }
        },

        :guitar_wahine_d => {
          :name => 'Guitar Wahine D (Dmaj7)',
          :tuning => %w{ D A D F# A C# }
        },

        :guitar_wahine_f => {
          :name => 'Guitar Wahine F (Fmaj7)',
          :tuning => %w{ C F C G C E }
        },

        :guitar_mauna_loa => {
          :name => 'Guitar Mauna Loa (A min 7)',
          :tuning => %w{ C G E G A E }
        },

        :guitar_old_mauna_loa => {
          :name => 'Guitar old Mauna Loa (A min 7 add4)',
          :tuning => %w{ C G C G A D }
        },

        :guitar_double_slack_f => {
          :name => 'Guitar double slack F',
          :tuning => %w{ C F C E A C }
        },

                :guitar_open_asus2 => {
          :name => 'Guitar open Asus2',
          :tuning => %w{ E A B E A E }
        },

        :guitar_open_asus4 => {
          :name => 'Guitar open Asus4',
          :tuning => %w{ E A D E A E }
        },

        :guitar_open_c6 => {
          :name => 'Guitar open C6',
          :tuning => %w{ C A C G C E }
        },

        :guitar_open_page => {
          :name => 'Guitar open Page',
          :tuning => %w{ D G C G C D }
        },

        :guitar_open_csus2 => {
          :name => 'Guitar open Csus2',
          :tuning => %w{ C G C G C D }
        },

        :guitar_open_csus4_9 => {
          :name => 'Guitar open Csus4+9',
          :tuning => %w{ C G C F C D }
        },

        :guitar_open_csus4 => {
          :name => 'Guitar open Csus4',
          :tuning => %w{ C G C G C F }
        },

        :guitar_open_c15 => {
          :name => 'Guitar open C15',
          :tuning => %w{ C G D G C D }
        },

        :guitar_open_dsus2 => {
          :name => 'Guitar open Dsus2',
          :tuning => %w{ D A D E A D }
        },

        :guitar_open_dsus4 => {
          :name => 'Guitar open Dsus4',
          :tuning => %w{ D A D G A D }
        },

        :guitar_open_esus2 => {
          :name => 'Guitar open Esus2',
          :tuning => %w{ E A E F# B E }
        },

        :guitar_open_esus4 => {
          :name => 'Guitar open Esus4',
          :tuning => %w{ E A E A B E }
        },

        :guitar_open_gsus2 => {
          :name => 'Guitar openGsus2',
          :tuning => %w{ D G D G A D }
        },

        :guitar_open_gsus4 => {
          :name => 'Guitar open Gsus4',
          :tuning => %w{ D G D G C D }
        },

        :guitar_open_e_modal => {
          :name => 'Guitar open E modal',
          :tuning => %w{ E B E E B E }
        },

        :guitar_open_g_modal => {
          :name => 'Guitar open G modal',
          :tuning => %w{ G G D G B D }
        },

        :guitar_open_b_modal => {
          :name => 'Guitar open B modal',
          :tuning => %w{ B F# C# F# B D# }
        },

        :guitar_open_c_sharp => {
          :name => 'Guitar open C#',
          :tuning => %w{ C# F# B E G# C# }
        },

        :guitar_terz_tuning => {
          :name => 'Guitar Terz tuning',
          :tuning => %w{ G C F A# D G }
        },

        :guitar_cross_note_a => {
          :name => 'Guitar cross note A',
          :tuning => %w{ E A E A C E }
        },

        :guitar_cross_note_a_alt_1 => {
          :name => 'Guitar cross note A alt. 1',
          :tuning => %w{ E A C E A E }
        },

        :guitar_cross_note_c => {
          :name => 'Guitar cross note C',
          :tuning => %w{ C G C G C D# }
        },

        :guitar_cross_note_f => {
          :name => 'Guitar cross note F',
          :tuning => %w{ F G# C F C F }
        },

        :guitar_cross_note_f_alt_1 => {
          :name => 'Guitar cross note F alt. 1',
          :tuning => %w{ F C F G# C F }
        },

        :guitar_open_dmin7 => {
          :name => 'Guitar open Dmin7',
          :tuning => %w{ D A D F A C }
        },

        :guitar_open_dmin_add9 => {
          :name => 'Guitar open Dmin add9 ',
          :tuning => %w{ D A D F A E }
        },

        :guitar_open_emin7 => {
          :name => 'Guitar open Emin7',
          :tuning => %w{ E B D G B E }
        },

        :dobro_open_g6 => {
          :name => 'Dobro open G6',
          :tuning => %w{ G B D G B E }
        },

        :guitar_open_g7_alt_1 => {
          :name => 'Guitar open G7 alt. 1',
          :tuning => %w{ D G D G B F }
        },

        :guitar_open_g7_alt_2 => {
          :name => 'Guitar open G7 alt. 2',
          :tuning => %w{ D G D F B D }
        },

        :guitar_open_g7_alt_3 => {
          :name => 'Guitar open G7 alt. 3',
          :tuning => %w{ F G D G B D }
        },

        :guitar_open_gmaj7 => {
          :name => 'Guitar open Gmaj7',
          :tuning => %w{ D G D F# B D }
        },

        :guitar_open_g7_modal => {
          :name => 'Guitar open G7 modal',
          :tuning => %w{ F G D G C D }
        },

        :guitar_open_g13 => {
          :name => 'Guitar open G13',
          :tuning => %w{ F G D G B E }
        },

        :guitar_open_cmin7 => {
          :name => 'Guitar open Cmin7',
          :tuning => %w{ C G C G A# D# }
        },

        :guitar_open_cmaj7 => {
          :name => 'Guitar open Cmaj7',
          :tuning => %w{ C G C G B E }
        },

        :guitar_open_c6_9 => {
          :name => 'Guitar open C6/9',
          :tuning => %w{ C G C E A C }
        },

        :guitar_open_cmaj9 => {
          :name => 'Guitar open Cmaj9',
          :tuning => %w{ C G D G B E }
        },

        :guitar_csus2add11 => {
          :name => 'Guitar Csus2add11',
          :tuning => %w{ C G D F C F }
        },

        :guitar_golden_blue => {
          :name => 'Guitar Golden Blue',
          :tuning => %w{ C C C C A# F }
        },

        :guitar_open_gsus4 => {
          :name => 'Guitar open Gsus4',
          :tuning => %w{ D G C G C D }
        },

        :guitar_gorac => {
          :name => 'Guitar Gorac',
          :tuning => %w{ B G D G A E }
        },

        :mandolin_standard => {
          :name => 'Mandolin standard',
          :tuning => %w{ G D A E }
        },

        :mandolin_whole_step_flat => {
          :name => 'Mandolin whole step flat',
          :tuning => %w{ F C G D }
        },

        :mandolin_open_c => {
          :name => 'Mandolin open C',
          :tuning => %w{ G C E G }
        },

        :mandolin_open_d => {
          :name => 'Mandolin open D',
          :tuning => %w{ A D F# D }
        },

        :mandolin_open_e => {
          :name => 'Mandolin open E',
          :tuning => %w{ G# E B E }
        },

        :mandolin_open_g => {
          :name => 'Mandolin open G',
          :tuning => %w{ G D B D }
        },

        :mandolin_open_a => {
          :name => 'Mandolin open A',
          :tuning => %w{ A C# A E }
        },

        :mandolin_drop_d => {
          :name => 'Mandolin drop D',
          :tuning => %w{ G D A D }
        },

        :mandolin_modal_d => {
          :name => 'Mandolin modal D',
          :tuning => %w{ G D A D }
        },

        :mandolin_modal_e => {
          :name => 'Mandolin modal E',
          :tuning => %w{ A E B E }
        },

        :mandolin_modal_a => {
          :name => 'Mandolin modal A',
          :tuning => %w{ A D E A }
        },

        :mandolin_dead_mans => {
          :name => "Mandolin - Dead Man's Tuning",
          :tuning => %w{ D D A D }
        },

        :mandolin_alto => {
          :name => 'Mandolin alto (fourth flat)',
          :tuning => %w{ D A E B }
        },

        :citern_italian => {
          :name => 'Cittern - Italian',
          :tuning => %w{ B G D E }
        },

        :cittern_french => {
          :name => 'Cittern - French',
          :tuning => %w{ A G D E }
        },

        :mandola => {
          :name => 'Mandola',
          :tuning => %w{ C G D A }
        },

        :fiddle_standard => {
          :name => 'Fiddle standard',
          :tuning => %w{ G D A E }
        },

        :banjo_standard => {
          :name => 'Banjo standard',
          :tuning => %w{ G D G B D }
        },

        :dorbo_standard => {
          :name => 'Dobro standard',
          :tuning => %w{ G B D G B D }
        },

        :lute_standard => {
          :name => 'Lute standard',
          :tuning => %w{ E A D F# B E }
        },

        :guitar_baritone_fourth => {
          :name => 'Guitar baritone (down a 4th)',
          :tuning => %w{ B E A D F# B }
        },

        :guitar_baritone_fifth => {
          :name => 'Guitar baritone (down a 5th)',
          :tuning => %w{ A D G C E A }
        },

        :bass_four_string => {
          :name => 'Bass standard',
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

        :guitar_perfect_4th => {
          :name => 'Guitar perfect 4th',
          :tuning => %w{ E A D G C F }
        },

        :guitar_open_c6th_5 => {
          :name => 'Guitar open C 6th-5',
          :tuning => %w{ C G D F# A D }
        },

        :guitar_open_cmaj7 => {
          :name => 'Guitar open CMaj7',
          :tuning => %w{ C G D G B D }
        },

        :guitar_open_cmaj6 => {
          :name => 'Guitar open Cmaj6',
          :tuning => %w{ C G C G A E }
        },

        :guitar_open_c6add9 => {
          :name => 'Open open C6add9',
          :tuning => %w{ C G D G A D }
        },

        :ukulele_tenor => {
          :name => 'Ukulele tenor',
          :tuning => %w{ G C E A }
        },

        :ukulele_baritone => {
          :name => 'Ukulele baritone',
          :tuning => %w{ D G B E }
        },

        :ukulele_soprano => {
          :name => 'Ukulele soprano',
          :tuning => %w{ A D F# B }
        },

        :strumstick_standard => {
          :name => 'Strumstick standard',
          :tuning => %w{ G D G }
        },

        :strumstick_grand => {
          :name => 'Strumsick Grand',
          :tuning => %w{ D A D }
        },

        :tres => {
          :name => 'Latin tres',
          :tuning => %w{ G C E }
        },
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

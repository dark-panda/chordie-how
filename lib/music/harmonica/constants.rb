# encoding: UTF-8

module Music
  module Harmonica
    module Constants
      TUNINGS = {
        :standard => {
          :name => 'standard Richter diatonic',
          :tuning => [
            [ 0, 2 ],
            [ 4, 7 ],
            [ 7, 11 ],
            [ 0, 2 ],
            [ 4, 5 ],
            [ 7, 9 ],
            [ 0, 11 ],
            [ 4, 2 ],
            [ 7, 5 ],
            [ 0, 9 ]
          ]
        },

        :sohne => {
          :name => 'C.A. Seydel Sohne',
          :tuning => [
            [ 4, 7 ],
            [ 7, 11 ],
            [ 0, 2 ],
            [ 4, 5 ],
            [ 7, 9 ],
            [ 0, 11 ],
            [ 4, 2 ],
            [ 7, 5 ],
            [ 0, 9 ],
            [ 4, 11 ]
          ]
        },

        :piccolo_sohne => {
          :name => 'Piccolo C.A. Seydel Sohne',
          :tuning => [
            [ 4, 7 ],
            [ 7, 11 ],
            [ 0, 2 ],
            [ 4, 5 ],
            [ 7, 9 ],
            [ 0, 11 ],
            [ 0, 2 ],
            [ 4, 5 ],
            [ 7, 9 ],
            [ 0, 11 ]
          ]
        },

        :melody_maker => {
          :name => 'Lee Oskar Melody Maker',
          :tuning => [
            [ 0, 2 ],
            [ 4, 7 ],
            [ 9, 11 ],
            [ 0, 2 ],
            [ 4, 6 ],
            [ 7, 9 ],
            [ 0, 11 ],
            [ 4, 2 ],
            [ 7, 6 ],
            [ 0, 9 ]
          ]
        },

        :harmonic_minor => {
          :name => 'Lee Oskar Harmonic Minor',
          :tuning => [
            [ 0, 2 ],
            [ 3, 7 ],
            [ 7, 11 ],
            [ 0, 2 ],
            [ 3, 5 ],
            [ 7, 8 ],
            [ 0, 11 ],
            [ 3, 2 ],
            [ 7, 5 ],
            [ 0, 8 ]
          ]
        },

        :country => {
          :name => 'Country tuning',
          :tuning => [
            [ 0, 4 ],
            [ 5, 7 ],
            [ 9, 0 ],
            [ 0, 4 ],
            [ 5, 7 ],
            [ 9, 11 ],
            [ 0, 2 ],
            [ 5, 4 ],
            [ 9, 7 ],
            [ 0, 10 ]
          ]
        },

        :paddy_richter => {
          :name => 'Paddy Richter tuning',
          :tuning => [
            [ 0, 2 ],
            [ 4, 7 ],
            [ 9, 11 ],
            [ 0, 2 ],
            [ 4, 5 ],
            [ 7, 9 ],
            [ 0, 11 ],
            [ 4, 2 ],
            [ 7, 5 ],
            [ 0, 9 ]
          ]
        },

        :richter_extended => {
          :name => 'Richter extended tuning',
          :tuning => [
            [ 0, 2 ],
            [ 4, 7 ],
            [ 7, 11 ],
            [ 0, 2 ],
            [ 4, 7 ],
            [ 7, 11 ],
            [ 0, 2 ],
            [ 4, 7 ],
            [ 7, 11 ],
            [ 0, 2 ]
          ]
        }
      }.freeze

      POSITIONS = {
        1 => {
          :name => 'first',
          :key => 0
        },

        2 => {
          :name => 'second',
          :key => 7
        },

        3 => {
          :name => 'third',
          :key => 2
        },

        4 => {
          :name => 'fourth',
          :key => 9
        },

        5 => {
          :name => 'fifth',
          :key => 4
        },

        6 => {
          :name => 'sixth',
          :key => 11
        },

        7 => {
          :name => 'seventh',
          :key => 6
        },

        8 => {
          :name => 'eighth',
          :key => 1
        },

        9 => {
          :name => 'ninth',
          :key => 8
        },

        10 => {
          :name => 'tenth',
          :key => 3
        },

        11 => {
          :name => 'eleventh',
          :key => 10
        },

        12 => {
          :name => 'twelfth',
          :key => 5
        }
      }.freeze

      CSS_STYLES = {
        :'table.harmonica-diagram' => {
          'border-collapse' => 'collapse',
          'border' => '1px solid #cccccc',
          'text-align' => 'center',
          'font-size' => 'small',
          'margin' => '0pt auto',
          'background-color' => 'white'
        },

        :'table.harmonica-diagram td' => {
          'border' => '1px solid #cccccc',
          'padding' => '3px',
          'width' => '2em',
          'height' => '2em'
        },

        :'table.harmonica-diagram td.empty' => {
          'background-color' => 'silver',
          'border' => 'none'
        },

        :'table.harmonica-diagram tr.holes' => {
          'background-color' => 'black',
          'color' => 'white',
          'font-weight' => 'bold'
        }
      }.freeze
    end
  end
end

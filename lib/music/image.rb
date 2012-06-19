# encoding: UTF-8

begin
  require 'gd2-ffij'
  require File.join(File.dirname(__FILE__), 'gd2_extensions')
rescue Exception
end

module Music
  module Image
    class ImageException < MusicException; end
    class GD2Missing < ImageException; end

    FONT_PATH = File.join(File.expand_path(File.dirname(__FILE__)),
      %w{ .. .. vendor fonts ttf DejaVuSans.ttf })

    if defined? GD2
      COLORS = {
        :'gray' => GD2::Color[0xAA, 0xAA, 0xAA],
        :'white' => GD2::Color[255, 255, 255],
        :'black' => GD2::Color[0, 0, 0],

        :'background' => GD2::Color[255, 255, 255, 1.0],
        :'frets' => GD2::Color[0xff, 0xff, 0xff],
        :'strings' => GD2::Color[0xaa, 0xaa, 0xaa],

        :'fretboard' => {
          :from => GD2::Color[0x92, 0x4F, 0x15],
          :to =>   GD2::Color[0xFF, 0xBF, 0x28]
        },

        :'watermark' => {
          :bg => GD2::Color[0, 0, 255],
          :fg => GD2::Color[0, 0, 0]
        },

        :'tonic' => {
          :bg => GD2::Color[0xAA, 0x19, 0x19],
          :fg => GD2::Color[255, 255, 255]
        },

        :'minor-second' => {
          :bg => GD2::Color[0x00, 0xC9, 0x00],
          :fg => GD2::Color[0, 0, 0]
        },

        :'major-second' => {
          :bg => GD2::Color[0x00, 0x5F, 0x00],
          :fg => GD2::Color[255, 255, 255]
        },

        :'minor-third' => {
          :bg => GD2::Color[0xCA, 0x90, 0xFF],
          :fg => GD2::Color[0, 0, 0]
        },

        :'major-third' => {
          :bg => GD2::Color[0x90, 0x00, 0xFF],
          :fg => GD2::Color[255, 255, 255]
        },

        :'fourth' => {
          :bg => GD2::Color[0xFF, 0xDC, 0x00],
          :fg => GD2::Color[0, 0, 0]
        },

        :'diminished-fifth' => {
          :bg => GD2::Color[0xFF, 0xC9, 0x90],
          :fg => GD2::Color[0, 0, 0]
        },

        :'perfect-fifth' => {
          :bg => GD2::Color[0xFF, 0x8E, 0x00],
          :fg => GD2::Color[255, 255, 255]
        },

        :'minor-sixth' => {
          :bg => GD2::Color[0xB5, 0xE3, 0xE5],
          :fg => GD2::Color[0, 0, 0]
        },

        :'major-sixth' => {
          :bg => GD2::Color[0x00, 0xB4, 0xBE],
          :fg => GD2::Color[255, 255, 255]
        },

        :'minor-seventh' => {
          :bg => GD2::Color[0x73, 0xA2, 0xD7],
          :fg => GD2::Color[0, 0, 0]
        },

        :'major-seventh' => {
          :bg => GD2::Color[0x00, 0x69, 0xBA],
          :fg => GD2::Color[255, 255, 255]
        }
      }
    end

    # Converts the name of the interval to a suitable HTML class.
    def interval_to_gd2_color(intervals, note)
      note = find_note_from_index(note) if note.is_a?(Fixnum)

      if klass = intervals.detect { |x| x[0] == note }
        COLORS[klass.last.gsub(/[^a-z]/, '-').to_sym]
      else
        nil
      end
    end
  end
end

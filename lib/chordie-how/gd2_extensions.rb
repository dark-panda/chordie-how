# encoding: UTF-8

if defined? GD2
  module GD2
    class Canvas
      def rectangle_with_gradient(x1, y1, x2, y2, options = {})
        options = {
          :from_color => GD2::Color[0, 0, 0],
          :to_color => GD2::Color[0xff, 0xff, 0xff],
          :orientation => :horizontal
        }.merge(options)

        old_color, from_color, to_color = self.color, options[:from_color].dup, options[:to_color]

        step = if options[:orientation] == :horizontal
          (x1 - x2).abs.to_f
        else
          (y2 - y1).abs.to_f
        end

        step_r = minmax_color(from_color.red, to_color.red, step)
        step_g = minmax_color(from_color.green, to_color.green, step)
        step_b = minmax_color(from_color.blue, to_color.blue, step)

        self.color = @image.palette.resolve(from_color)
        FilledRectangle.new(point(x1, y1), point(x2, y2)).draw(@image, line_pixel)

        rng = if options[:orientation] == :horizontal
          x1...x2
        else
          y1...y2
        end

        rng.step do |i|
          break if from_color.red >= to_color.red &&
            from_color.green >= to_color.green &&
            from_color.blue >= to_color.blue

          from_color.red += step_r unless from_color.red >= to_color.red
          from_color.green += step_g unless from_color.green >= to_color.green
          from_color.blue += step_b unless from_color.blue >= to_color.blue

          self.color = @image.palette.resolve(from_color)

          pt = if options[:orientation] == :horizontal
            point(i, y1)
          else
            point(x1, i)
          end

          FilledRectangle.new(pt, point(x2, y2)).draw(@image, fill_pixel)
        end

        ensure
          self.color = old_color
      end

      private
        def minmax_color(from, to, step)
          [
            [
              [ to - from, 255 ].min,
              0
            ].max / step,
            1
          ].max.ceil
        end
    end
  end
end

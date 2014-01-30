# encoding: UTF-8

module ChordieHow
  module Keyboard
    module Utils
      def highlight(c, if_condition)
        if if_condition
          interval_to_html_class(@intervals, c)
        else
          'note'
        end
      end

      self.extend(self)
    end
  end
end

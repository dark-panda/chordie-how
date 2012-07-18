# encoding: UTF-8

require 'builder'

require 'chordie-how/midi'
require 'chordie-how/utils'

class ChordieHow::Harmonica::Scale
  include ChordieHow::Midi
  include ChordieHow::Utils
  include ChordieHow::Harmonica::Constants

  attr_reader :key, :pattern, :notes, :intervals, :tuning, :position, :position_key

  def initialize key, pattern = :major, options = {}
    options = {
      :tuning => :standard,
      :position => 1
    }.merge options

    @key = key
    @pattern = find_scale_pattern(pattern)
    @position = options[:position].to_i
    @position_key = find_note_from_index(NOTES.index(@key) + POSITIONS[position][:key])
    @notes = find_scale_notes(@position_key, @pattern)
    @intervals = find_intervals(@position_key, @notes)

    if Symbol === options[:tuning] || String === options[:tuning]
      if TUNINGS[options[:tuning].to_sym]
        @tuning = TUNINGS[options[:tuning].to_sym][:tuning]
      else
        raise ChordieHow::BadTuning.new(options[:tuning])
      end
    elsif Hash === options[:tuning] && options[:tuning][:tuning]
      @tuning = options[:tuning][:tuning]
    elsif Array === options[:tuning]
      @tuning = options[:tuning]
    end
  end

  # Outputs an HTML table showing the positions, blows, draws and
  # (optionally) the bends available.
  def to_html options = {}
    options = {
      :class => 'harmonica-diagram',
      :highlight_intervals => true,
      :embed_styles => false,
      :show_notes => true,
      :show_bends => true
    }.merge options

    start = find_note_from_char(@key)

    if options[:show_bends]
      bends, max_bend, min_bend = calculate_bends
    end

    td_style = build_css(CSS_STYLES[:'table.harmonica-diagram td'])
    td_empty_style = build_css(CSS_STYLES[:'table.harmonica-diagram td.empty'])

    table_attributes = {
      :class => options[:class]
    }
    table_attributes.merge!({
      :style => build_css(CSS_STYLES[:'table.harmonica-diagram'])
    }) if options[:embed_styles]

    xml = Builder::XmlMarkup.new(:indent => 4)
    xml.table(table_attributes) do
      if options[:show_bends]
        (max_bend - 1).downto(1) do |i|
          xml.tr(:class => 'bends') do
            if i == (max_bend - 1)
              attributes = {
                :rowspan => (max_bend - 1).abs
              }
              attributes.merge!({
                :style => td_style
              }) if options[:embed_styles]
              xml.td('Bends', attributes)
            end

            @tuning.each_with_index do |t, b|
              if i < bends[b]
                c = start + t[0] - i
                n = find_note_from_index(c)
                attributes = td_attributes(td_style, n, c, options)
                xml.td(attributes) { xml << (options[:show_notes] ? n : '&nbsp;') }
              else
                attributes = {
                  :class => 'empty'
                }.merge(td_attributes(td_empty_style, nil, nil, options))
                xml.td(attributes) { xml << '&nbsp;' }
              end
            end
          end
        end
      end

      xml.tr(:class => 'blow') do
        xml.td('Blow', td_attributes(td_style, nil, nil, options))
        @tuning.each do |t|
          c = start + t[0]
          n = find_note_from_index(c)
          xml.td(td_attributes(td_style, n, c, options)) do
            xml << (options[:show_notes] ? n : '&nbsp;')
          end
        end
      end

      tr_attributes = {
        :class => 'holes'
      }
      tr_attributes.merge!({
        :style => build_css(CSS_STYLES[:'table.harmonica-diagram tr.holes'])
      }) if options[:embed_styles]

      xml.tr(tr_attributes) do
        xml.td('Position')
        @tuning.length.times do |t|
          xml.td(t + 1)
        end
      end

      xml.tr(:class => 'draw') do
        xml.td('Draw', td_attributes(td_style, nil, nil, options))
        @tuning.each do |t|
          c = start + t[1]
          n = find_note_from_index(c)
          xml.td(td_attributes(td_style, n, c, options)) do
            xml << (options[:show_notes] ? n : '&nbsp;')
          end
        end
      end

      if options[:show_bends]
        -1.downto(min_bend + 1) do |i|
          xml.tr(:class => 'bends') do
            if i == -1
              attributes = {
                :rowspan => (min_bend + 1).abs
              }
              attributes.merge!({
                :style => td_style
              }) if options[:embed_styles]
              xml.td('Bends', attributes)
            end

            @tuning.each_with_index do |t, b|
              if i > bends[b]
                c = start + t[1] + i
                n = find_note_from_index(c)
                attributes = td_attributes(td_style, n, c, options)
                xml.td(attributes) { xml << (options[:show_notes] ? n : '&nbsp;') }
              else
                attributes = {
                  :class => 'empty'
                }.merge(td_attributes(td_empty_style, nil, nil, options))
                xml.td(attributes) { xml << '&nbsp;' }
              end
            end
          end
        end
      end
    end
  end

  def to_midi options = {}
    options = {
      :instrument => 'Harmonica',
      :key => @position_key
    }.merge options
    super options
  end

  protected
    # Highlight a note if if_condition is true.
    def highlight c, if_condition
      if if_condition
        interval_to_html_class(@intervals, c)
      else
        if @notes.include? find_note_from_index(c)
          'note'
        end
      end
    end

    # Here we're figuring out how far we can bend each note in
    # each position. Basically, we figure out how far the draw
    # and blow notes are away from each other. We don't take into
    # account overblows and such.
    def calculate_bends
      start = find_note_from_char(@key)
      bends = @tuning.collect do |t|
        shortest_distance(start + t[0], start + t[1])
      end

      max_bend = bends.max
      min_bend = bends.min

      [ bends, max_bend, min_bend ]
    end


    def td_attributes(td_style, n, c, options)
      klass, style = if @notes.include?(n)
        klass = if options[:highlight_intervals]
          interval_to_html_class(@intervals, c)
        else
          'note'
        end

        style = if options[:embed_styles]
          interval_class_to_style(klass)
        end
        [ klass, style ]
      end

      attributes = if klass
        { :class => klass }
      else
        Hash.new
      end

      if options[:embed_styles]
        attributes.merge!(:style => "#{td_style} #{style}")
      end

      attributes
    end
end

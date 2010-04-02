
require 'builder'

require 'music/midi'
require 'music/utils'
require 'music/image'
require 'music/keyboard/utils'

module Music::Keyboard::Diagrams
	include Music::Midi
	include Music::Utils
	include Music::Image
	include Music::Keyboard::Utils

	def self.included(base)
		base.instance_eval do
			protected :white_key
			protected :black_key
		end
	end

	# Build an HTML table displaying the scale.
	#
	# * :show_notes - include a row containing the note names across
	#   the top of the table. Default is true.
	# * :highlight_intervals - use CSS to colour in the keys using
	#   our interval colours. Default is true.
	# * :class - the CSS class to give the table. The default is
	#   "keyboard-diagram".
	def to_html options = {}
		options = {
			:show_notes => true,
			:highlight_intervals => true,
			:class => 'keyboard-diagram'
		}.merge options

		xml = Builder::XmlMarkup.new(:indent => 4)
		xml.table(:class => options[:class]) do
			# We're going to start from C# on the top half of our table
			# for the black keys.
			start = NOTES.index('C#')

			# This first little section puts the names of our notes
			# across the top of the table. We use 35 cells across
			# because that's what it's going to take to write them all
			# properly.
			if options[:show_notes]
				xml.tr(:class => 'notes') do
					xml.td('C')
					11.times do |i|
						c = find_note_from_index(i + start)
						xml.td(c,
							[ 'A', 'D', 'G' ].include?(c) ? {} : { :colspan => '2' }
						)
					end
				end
			end

			# This next section handles the black keys and the top
			# halves of the white keys.
			xml.tr(:class => 'top-half') do
				n = @notes.dup

				# If n is C (our first key) then we need to colour
				# it.
				attributes = if n.first == 'C'
					n.delete('C')
					if options[:highlight_intervals]
						klass = interval_to_html_class(@intervals, 'C')
						style = interval_class_to_style(klass)
						{ :class => "key-l-e #{klass}", :style => style }
					else
						{ :class => 'key-l-e note', :style => interval_class_to_style('note') }
					end
				end

				xml.td(nil, attributes)

				# Now we handle the rest of the keys.
				11.times do |i|
					c = find_note_from_index(i + start)

					klass, style = if !n.empty? && n.first == c
						n.delete(c)
						if options[:highlight_intervals]
							klass = interval_to_html_class(@intervals, c)
							style = interval_class_to_style(klass)
							[ klass, style ]
						else
							[ 'note', interval_class_to_style('note') ]
						end
					end

					# This section here draws our keys. Each section
					# of the keyboard is going to have three
					# components: part of a white key and two parts of
					# a black key. In some cases (where we're drawing
					# the top parts of the E/F and B/C keys, things
					# are bit more complicated. In any event, by the
					# time we're done we have a respectable looking
					# top half of a keyboard layout.
					case c
						when 'D', 'G', 'A'
							xml.td(nil, :class => "key-c #{klass}", :style => style)

						when 'C#', 'D#', 'F#', 'G#', 'A#'
							xml.td(nil, :class => "key-r-b #{klass}", :style => style)
							xml.td(nil, :class => "key-l-b #{klass}", :style => style)

						when 'B', 'E'
							xml.td(nil, :class => "key-c #{klass}", :style => style)
							xml.td(nil, :class => "key-r #{klass}", :style => style)

						when 'C', 'F'
							xml.td(nil, :class => "key-l #{klass}", :style => style)
							xml.td(nil, :class => "key-c #{klass}", :style => style)
					end
				end
			end

			# This next section draws the bottom half of the keyboard.
			xml.tr(:class => 'bottom-half') do
				n = @notes.dup
				# Since we're only dealing with white keys here, filter
				# out all of the sharps/flats.
				bottom_notes = NOTES.select { |x| x.length == 1 }

				# Again, we're starting with C, so we need to do some
				# special work to colour it in if necessary.
				start = NOTES.index('C')

				if n.first == 'C'
					n.delete('C')
					klass = highlight('C', options[:highlight_intervals])
				end

				xml.td(nil, :class => "key-l-e #{klass}")
				xml.td(nil, :class => "key-r #{klass}")

				# This time we only use 20 this time since we only have
				# 20 white keys.
				6.times do |i|
					c = bottom_notes[(i + start).modulo(bottom_notes.length)]
					klass = nil

					# We're only showing simple chords here, so we're
					# going to colour the keys necessary to build
					# the note from left to right. Once we've found a
					# note we need we kick it out of the n Array and
					# continue on.
					if !n.empty? && n.first == c
						n.shift
						klass = highlight(c, options[:highlight_intervals])
					else
						n.shift if n.first =~ /\#$/
					end

					xml.td(nil, :class => "key-l #{klass}")
					xml.td(nil, :class => "key-c #{klass}")
					xml.td(nil, :class => "key-r #{klass}")
				end
			end
		end
	end

	# Displays the scale using some ASCII art.
	#
	# * :show_notes - whether or not to display the note names across
	#   and below the generated ASCII art. Default is true.
	def to_txt options = {}
		options = {
			:show_notes => true
		}.merge options

		symbols = find_single_symbols(@key, @notes)

		# First we start off with the black keys and the upper half
		# of the white keys.
		start = NOTES.index('C#')
		retval = String.new

		if options[:show_notes]
			retval += "   "
			11.times do |i|
				c = find_note_from_index(i + start)
				case c
					when 'C#', 'D#', 'F#', 'G#', 'A#'
						retval += " #{c} "
					when 'D', 'A', 'G'
						retval += " "
					when 'E', 'F', 'B', 'C'
						retval += "  "
				end
			end
			retval += " \n"
		end

		# This first bit is for the top of the chart.
		retval += "╔"
		retval += "═╤═══╤╤═══╤═╤═╤═══╤╤═══╤╤═══╤═╤"
		retval += "╗\n"

		# This next bit extends the keys down a couple of lines.
		5.times do
				retval += "║"
				retval += " │   ││   │ │ │   ││   ││   │ │"
				retval += "║\n"
		end

		# This section fills in the black keys with interval symbols
		# as necessary.
		retval += "║ │"
		n = @notes.select { |x| x.length == 2 }
		11.times do |i|
			c = find_note_from_index(i + start)
			case c
				when 'C#', 'D#', 'F#', 'G#', 'A#'
					if !n.empty? && n.first == c
						n.delete(c)
						retval += (symbols.detect { |x| x[0] == c }[1]).rjust(3) + "│"
					else
						retval += "   │"
					end

				when 'D', 'A', 'G'
					retval += "│"

				when 'E', 'F', 'B', 'C'
					retval += " │"
			end
		end
		retval += "║\n"

		# This section is for the bottom of the black keys and
		# concludes the top half of the diagram.
		retval += "║"
		retval += " └─┬─┘└─┬─┘ │ └─┬─┘└─┬─┘└─┬─┘ │"
		retval += "║\n"

		# Next we extend the white keys down a bit.
		4.times do
			retval += "║"
			retval += "   │    │   │   │    │    │   │"
			retval += "║\n"
		end

		n = @notes.dup
		bottom_notes = NOTES.select { |x| x.length == 1 }
		start = NOTES.index('B')

		# This section labels the white keys as necessary.
		retval += "║"
		7.times do |i|
			c = bottom_notes[(i + start).modulo(bottom_notes.length)]

			if !n.empty? && n.first == c
				n.shift
				interval = symbols.detect { |x| x[0] == c }[1]
			else
				n.shift if n.first =~ /\#$/
				interval = ''
			end

			case c
				when 'B', 'C', 'E', 'F'
					retval += interval.rjust(3) + "│"

				when 'D', 'G', 'A'
					retval += interval.rjust(4) + "│"
			end
		end
		retval += "║\n"

		# Finally, the bottom part of our chart.
		retval += "╚"
		retval += "═══╧════╧═══╧═══╧════╧════╧═══╧"
		retval += "╝\n"

		if options[:show_notes]
			retval += " "
			7.times do |i|
				c = bottom_notes[(i + start).modulo(bottom_notes.length)]

				case c
					when 'B', 'C', 'E', 'F'
						retval += " #{c}  "

					when 'D', 'G', 'A'
						retval += "  #{c}  "
				end
			end
			retval += " \n"
		end

		retval
	end

	def to_image(options = {})
		options = {

		}.merge(options)

		width = 350
		height = 330

		image = GD2::Image::IndexedColor.new(width, height)
		image.draw do |pen|
			# set up background with transparency...
			pen.color = image.palette.resolve(COLORS[:background])

			# black outline...
			pen.color = image.palette.resolve(COLORS[:black])
			pen.rectangle(0, 0, width - 4, height - 4)

			# white background...
			pen.color = image.palette.resolve(COLORS[:white])
			pen.rectangle(1, 1, width - 5, height - 5, true)

			# drop shadow...
			pen.color = image.palette.resolve(COLORS[:gray])
			pen.thickness = 4
			pen.line(4, height - 1, width, height - 1)
			pen.line(width - 1, 4, width - 1, height)

			# back to default colours
			pen.color = image.palette.resolve(COLORS[:black])

			pen.thickness = 2
			pen.rectangle(5, 5, 340, 320)

			# for the lines between the white keys
			6.times do |offset|
				pen.move_to(5 + ((offset + 1) * 48), 5)
				pen.line_to(5 + ((offset + 1) * 48), 320)
			end

			white_key(image, 'C', 0)
			white_key(image, 'D', 1)
			white_key(image, 'E', 2)
			white_key(image, 'F', 3)
			white_key(image, 'G', 4)
			white_key(image, 'A', 5)
			white_key(image, 'B', 6)

			black_key(image, 'C#')
			black_key(image, 'D#', 1)
			black_key(image, 'F#', 3)
			black_key(image, 'G#', 4)
			black_key(image, 'A#', 5)
		end

		image
	end

	def to_png(options = {})
		self.to_image(options).png
	end

	def white_key(image, note, offset = 0)
		image.draw do |pen|
			if color = interval_to_gd2_color(@intervals, note)
				pen.color = image.palette.resolve(color[:bg])
				pen.move_to(20 + (offset * 48), 300)
				pen.fill
				pen.color = image.palette.resolve(color[:fg])
				pen.font = GD2::Font::TrueType[FONT_PATH, 12]
				pen.text find_single_symbols(@key, note).first.last
			end
		end
	end

	def black_key(image, note, offset = 0)
		image.draw do |pen|
			bg, fg = if color = interval_to_gd2_color(@intervals, note)
				[
					image.palette.resolve(color[:bg]),
					image.palette.resolve(color[:fg])
				]
			else
				image.palette.resolve(COLORS[:black])
			end

			pen.color = bg
			offset = offset * 48
			width_offset = 30 + offset
			pen.rectangle(
				38 + offset, 6,
				width_offset + 38, 180,
				true
			)

			if fg
				pen.color = image.palette.resolve(color[:fg])
				pen.font = GD2::Font::TrueType[FONT_PATH, 12]
				pen.move_to(44 + offset, 160)
				pen.text find_single_symbols(@key, note).first.last
			end
		end
	end
end

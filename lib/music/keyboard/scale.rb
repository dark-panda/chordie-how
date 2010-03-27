
require 'builder'

require 'music/utils'
require 'music/midi'
require 'music/keyboard/utils'

class Music::Keyboard::Scale
	include Music::Utils
	include Music::Midi
	include Music::Keyboard
	include Music::Keyboard::Utils

	attr_reader :key, :pattern, :notes, :intervals

	def initialize key, pattern = :major, options = {}
		options = {
		}.merge options

		@key = key
		@pattern = find_scale_pattern(pattern)
		@notes = find_scale_notes(@key, @pattern)
		@intervals = find_intervals(@key, @notes)
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
					35.times do |i|
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
				# If n is C (our first key) then we need to colour
				# it.
				if @notes.include?('C')
					klass = highlight('C', options[:highlight_intervals])
				end

				xml.td(nil, :class => "key-l-e #{klass}")

				# Now we handle the rest of the keys.
				35.times do |i|
					c = find_note_from_index(i + start)
					klass = nil

					if @notes.include? c
						klass = highlight(c, options[:highlight_intervals])
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
							xml.td(nil, :class => "key-c #{klass}")

						when 'C#', 'D#', 'F#', 'G#', 'A#'
							xml.td(nil, :class => "key-r-b #{klass}")
							xml.td(nil, :class => "key-l-b #{klass}")

						when 'B', 'E'
							xml.td(nil, :class => "key-c #{klass}")
							xml.td(nil, :class => "key-r #{klass}")

						when 'C', 'F'
							xml.td(nil, :class => "key-l #{klass}")
							xml.td(nil, :class => "key-c #{klass}")

					end
				end
			end

			# This next section draws the bottom half of the keyboard.
			xml.tr(:class => 'bottom-half') do
				bottom_notes = NOTES.select { |x| x.length == 1 }

				# Again, we're starting with C, so we need to do some
				# special work to colour it in if necessary.
				start = NOTES.index('C')

				if @notes.include? 'C'
					klass = highlight('C', options[:highlight_intervals])
				end

				xml.td(nil, :class => "key-l-e #{klass}")
				xml.td(nil, :class => "key-r #{klass}")

				# This time we only use 20 this time since we only have
				# 20 white keys.
				20.times do |i|
					c = bottom_notes[(i + start).modulo(bottom_notes.length)]
					klass = nil

					# We're only showing simple chords here, so we're
					# going to colour the keys necessary to build
					# the note from left to right. Once we've found a
					# note we need we kick it out of the n Array and
					# continue on.
					if @notes.include? c
						klass = highlight(c, options[:highlight_intervals])
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
			35.times do |i|
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
		retval += "═╤═══╤╤═══╤═╤═╤═══╤╤═══╤╤═══╤═╤" * 3
		retval += "╗\n"

		# This next bit extends the keys down a couple of lines.
		5.times do
				retval += "║"
				retval += " │   ││   │ │ │   ││   ││   │ │" * 3
				retval += "║\n"
		end

		# This section fills in the black keys with interval symbols
		# as necessary.
		retval += "║ │"
		35.times do |i|
			c = find_note_from_index(i + start)
			case c
				when 'C#', 'D#', 'F#', 'G#', 'A#'
					if @notes.include? c
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
		retval += " └─┬─┘└─┬─┘ │ └─┬─┘└─┬─┘└─┬─┘ │" * 3
		retval += "║\n"

		# Next we extend the white keys down a bit.
		4.times do
				retval += "║"
				retval += "   │    │   │   │    │    │   │" * 3
				retval += "║\n"
		end

		bottom_notes = NOTES.select { |x| x.length == 1 }
		start = NOTES.index('B')

		# This section labels the white keys as necessary.
		retval += "║"
		21.times do |i|
			c = bottom_notes[(i + start).modulo(bottom_notes.length)]

			case c
				when 'B', 'C', 'E', 'F'
					if @notes.include? c
						retval += (symbols.detect { |x| x[0] == c }[1]).rjust(3) + "│"
					else
						retval += "   │"
					end

				when 'D', 'G', 'A'
					if @notes.include? c
						retval += (symbols.detect { |x| x[0] == c }[1]).rjust(4) + "│"
					else
						retval += "    │"
					end
			end
		end
		retval += "║\n"

		# Finally, the bottom part of our chart.
		retval += "╚"
		retval += "═══╧════╧═══╧═══╧════╧════╧═══╧" * 3
		retval += "╝\n"

		if options[:show_notes]
			retval += " "
			21.times do |i|
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
end

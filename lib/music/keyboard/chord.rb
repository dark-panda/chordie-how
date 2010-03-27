# The Chord class in this module is used for displaying a chord.
class Music::Keyboard::Chord
	include Music::Midi
	include Music::Utils
	include Music::Keyboard::Utils

	attr_reader :key, :type, :notes, :intervals

	# * key is the key of the chord, from NOTES.
	#
	# The only option at the moment is :type, which would be one of
	# the chord types from CHORD_TYPES. You can also use an Array of
	# intervals if you wish. See find_chord_notes for details.
	def initialize key, options = {}
		options = {
			:type => nil
		}.merge options

		@key = key
		@type = options[:type]
		@notes = find_chord_notes(@key, @type)
		@intervals = find_intervals(@key, @notes)
	end

	# Builds and returns the chord in an HTML table. The table is
	# basically built using two rows: one for the black keys and the
	# top halves of the white keys and one for the bottom halves of
	# the white keys. Using some clever use of colspans we can have a
	# decent looking keyboard using only HTML and a bit of CSS for
	# flavouring.
	def to_html options = {}
		options = {
			:class => 'keyboard-diagram',
			:highlight_intervals => true,
			:show_notes => true
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
			xml.tr(:class => 'top_half') do
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
				35.times do |i|
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
				20.times do |i|
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

	# Builds a String that can be used to display the chord as plaintext.
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
		n = @notes.select { |x| x.length == 2 }
		35.times do |i|
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
		retval += " └─┬─┘└─┬─┘ │ └─┬─┘└─┬─┘└─┬─┘ │" * 3
		retval += "║\n"

		# Next we extend the white keys down a bit.
		4.times do
				retval += "║"
				retval += "   │    │   │   │    │    │   │" * 3
				retval += "║\n"
		end

		n = @notes.dup
		bottom_notes = NOTES.select { |x| x.length == 1 }
		start = NOTES.index('B')

		# This section labels the white keys as necessary.
		retval += "║"
		21.times do |i|
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

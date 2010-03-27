
require 'builder'

require 'music/utils'
require 'music/midi'
require 'music/image'
require 'music/stringed/constants'
require 'music/stringed/utils'

# The Scale class, unlike the Chord class, should be accessed directly
# since figuring out the note positions on the fretboard is far less
# involved than with a chord.
class Music::Stringed::Scale
	include Music::Midi
	include Music::Utils
	include Music::Image
	include Music::Stringed
	include Music::Stringed::Constants
	include Music::Stringed::Utils

	attr_reader :key, :pattern, :notes, :intervals, :tuning

	# * key is the key of the chord, from NOTES.
	# * pattern is a Symbol representing a pattern from SCALE_PATTERNS
	#   or an Array representing the same.
	#
	# Options:
	#
	# * :tuning - the tuning to use for the open strings, either as a
	#   Symbol representing an entry in CHORD_TYPES or as an Array of
	#   intervals. The default is the standard for a six-string guitar
	#   (EADGBE).
	def initialize(key, pattern = :major, options = {})
		options = {
			:tuning => :standard
		}.merge options

		@key = key
		@pattern = find_scale_pattern(pattern)
		@tuning = find_open_strings(options[:tuning])
		@notes = find_scale_notes(@key, @pattern)
		@intervals = find_intervals(@key, @notes)
	end

	# Returns the tuning in an Array as the note names, i.e.
	# [ 'E', 'A', 'D', 'G', 'B', 'E' ].
	def tuning
		find_notes @tuning
	end

	# Returns the tuning as in Array in numerical form, where A == 0,
	# B == 2, C == 3, etc.
	def tuning_no
		@tuning
	end

	def to_html(options = {})
		options = {
			:class => 'scale-diagram',
			:highlight_intervals => true,
			:embed_style => false,
			:show_notes => true,
			:min_fret => 0,
			:max_fret => 12,
			:lefty => false
		}.merge options

		raise StringedException, "Please keep your frets to less than 32" if options[:max_fret].to_i > 32 || options[:min_fret].to_i > 32

		xml = Builder::XmlMarkup.new(:indent => 4)
		xml.table(:class => options[:class]) do
			fret_range = (options[:min_fret].to_i..options[:max_fret].to_i).collect
			fret_range.reverse! if options[:lefty]
			td_style = CSS_STYLES[:'table.scale-diagram td'].join(' ') if options[:embed_styles]

			@tuning.reverse_each do |t|
				xml.tr do
					fret_range.each do |f|
						n = find_note_from_index(t + f)
						klass, style = if @notes.include? n
							if options[:highlight_intervals]
								klass = interval_to_html_class(@intervals, n)
								style = if options[:embed_styles]
									interval_class_to_style(klass)
								end
								[ klass, style ]
							else
								[ 'note',
									(options[:embed_styles] ?
										interval_class_to_style('note') :
										nil
									)
								]
							end
						end
						
						attributes = if klass
							{ :class => klass }
						else
							Hash.new
						end

						if options[:embed_styles]
							attributes.merge!(
								:style => "#{td_style} #{style}"
							)
						end
						xml.td(attributes) do
							xml << (options[:show_notes] ? n : '&nbsp;')
						end
					end
				end
			end

			xml.tr do
				fret_range.each do |f|
					attributes = if options[:embed_styles]
						{ :style => td_style }
					end
					xml.td(f, attributes)
				end
			end
		end
	end

	def to_txt(options = {})
		options = {
			:min_fret => 0,
			:max_fret => 12,
			:show_intervals => true,
			:lefty => false
		}.merge options

		raise StringedException, "Please keep your frets to less than 32" if options[:max_fret].to_i > 32 || options[:min_fret].to_i > 32

		retval = String.new
		fret_range = (options[:min_fret].to_i..options[:max_fret].to_i).collect
		fret_range.reverse! if options[:lefty]
		symbols = find_single_symbols(@key)
		@tuning.reverse_each do |t|
			retval << '|' + NOTES[t].ljust(2, '-') + '|'
			fret_range.each do |f|
				n = find_note_from_index(t + f)
				if @notes.include? n
					if options[:show_intervals]
						retval << symbols.detect { |x| x.first == n }[1].center(3, '-') + '|'
					else
						retval << '-*-|'
					end
				else
					retval << '---|'
				end
			end
			retval << "\n"
		end
		retval << '    '
		fret_range.each do |f|
			retval << f.to_s.center(4)
		end

		return retval
	end

	def to_tab(options = {})
		options = {
			:min_fret => 0,
			:max_fret => 12,
			:lefty => false
		}.merge options

		raise StringedException, "Please keep your frets to less than 32" if options[:max_fret].to_i > 32 || options[:min_fret].to_i > 32

		retval = String.new
		tuning_range = @tuning.dup

		options[:min_fret].to_i.upto(options[:max_fret].to_i - 1) do |s|
			strings = Array.new
			tuning_range.each do |t|
				string = Array.new

				(s..(s + 4)).each do |f|
					n = find_note_from_index(t + f)
					if @notes.include? n
						string << f
						if strings.last.last == n
							strings.last.pop
						end unless strings.empty?
					end
				end
				strings << string
			end

			strings.reverse! unless options[:lefty]

			tab = Array.new
			strings.each do |s|
				tab << s.join('-')
			end

			ljust = String.new
			txt = Array.new
			tab.reverse_each do |t|
				txt << ljust + t
				ljust << ('-' * t.length) + '--'
			end

			txt.reverse! unless options[:lefty]
			max = txt.collect { |x| x.length }.max
			txt.each_with_index do |t, s|
				s = txt.length - s - 1 unless options[:lefty]
				retval << '|' + NOTES[@tuning[s]].ljust(2, '-') + '|-'
				retval << t + ('-' * (max - t.length)) + "-|\n"
			end
			2.times { retval << "\n" }
		end

		return retval
	end

	def to_midi(options = {})
		options = {
			:instrument => 'Acoustic Guitar (steel)'
		}.merge options
		super options
	end

	def to_png(options = {})
		options = {
			:highlight_intervals => true,
			:show_notes => true,
			:min_fret => 0,
			:max_fret => 12,
			:lefty => false
		}.merge(options)

		min_fret, max_fret = options[:min_fret], options[:max_fret]
		width_offset = 30
		height = (@tuning.length + 2) * 20 + 20
		width = (options[:max_fret] - options[:min_fret] + 2) * width_offset + 40
		font = File.join(File.expand_path(File.dirname(__FILE__)),
			'..', 'vendor', 'fonts', 'ttf', 'DejaVuSans.ttf')

		image = GD2::Image::IndexedColor.new width, height
		image_tuning = @tuning.dup.reverse

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
			pen.color = image.palette.resolve(COLORS[:white])

			pen.rectangle_with_gradient(
				40,
				20,
				width - 16,
				height - 52, {
					:from_color => COLORS[:fretboard][:from],
					:to_color => COLORS[:fretboard][:to],
					:orientation => :vertical
				}
			)

			pen.font = GD2::Font::TrueType[font, 10]
			pen.thickness = 2

			# frets
			fret_range = ((min_fret)..(max_fret)).to_a
			fret_range.reverse! if options[:lefty]
			fret_range.each_with_index do |f, i|
				pen.move_to(40 + width_offset * i, height - 30)
				pen.color = image.palette.resolve(COLORS[:black])
				pen.text f.to_s.rjust(2)
				x = 60 + width_offset * i
				pen.color = image.palette.resolve(COLORS[:frets])
				pen.line(x, 24, x, height - 56)
			end

			# strings and string notes
			self.tuning.reverse.each_with_index do |n, s|
				y = 24 + 20 * s
				pen.color = image.palette.resolve(COLORS[:strings])
				pen.line(40, y, width - 16, y)

				pen.move_to(10, width_offset + 20 * s)
				pen.color = image.palette.resolve(COLORS[:black])
				pen.text n.rjust(2)
			end

			# notes
			fret_range.each_with_index do |f, i|
				image_tuning.each_with_index do |t, s|
					n = find_note_from_index(image_tuning[s] + f)

					if @notes.include?(n)
						klass = interval_to_html_class(@intervals, n).to_sym
						pen.color = image.palette.resolve(COLORS[klass][:bg])
						pen.circle(48 + width_offset * i, 24 + 20 * s, 20, true)
						if n.length == 2
							pen.move_to(40 + width_offset * i, 30 + 20 * s)
						else
							pen.move_to(44 + width_offset * i, 30 + 20 * s)
						end
						pen.color = image.palette.resolve(COLORS[klass][:fg])
						pen.text n
					end
				end
			end
		end

		image.png
	end
end


module Music
	module Utils
		def self.included(base)
			base.send(:include, InstanceMethods)
		end

		module InstanceMethods
			include Music::Constants

			# Looks up a scale pattern. You can also use Arrays or Hashes
			# directly.
			def find_scale_pattern(pattern)
				if [ Symbol, String ].include?(pattern.class)
					if SCALE_PATTERNS[pattern.to_sym]
						SCALE_PATTERNS[pattern.to_sym][:pattern]
					else
						raise BadScalePattern.new(pattern)
					end
				elsif pattern.is_a?(Hash) && pattern[:pattern]
					pattern[:pattern]
				elsif pattern.is_a?(Array)
					pattern
				end
			end


			# Looks up a chord type. You can also use Arrays or Hashes
			# directly.
			def find_chord_type(t)
				if [ Symbol, String ].include?(t.class)
					if CHORD_TYPES[t.to_sym]
						CHORD_TYPES[t.to_sym][:intervals]
					else
						raise BadChordType.new(t)
					end
				elsif t.is_a?(Hash) && t[:intervals]
					t[:intervals]
				elsif t.is_a?(Array)
					t
				end
			end


			# Figure out the actual notes in the scale.
			#
			# * key is one of the notes from notes
			# * pattern is a pattern from SCALE_PATTERNS or an Array
			#   representing a pattern.
			def find_scale_notes(key, pattern)
				start = find_note_from_char(key)
				key_notes = [ key ]

				find_scale_pattern(pattern).each do |v|
					start += case v
						when 'h'
							1
						when 'w'
							2
						when 'wh'
							3
						when 'ww'
							4
						else
							raise BadScalePattern.new(v)
					end
					key_notes << find_note_from_index(start)
				end

				# This is good... a proper scale... otherwise, we should popup
				# a warning that this scale isn't all that great, as it doesn't
				# end in the same note it starts from...
				if (key_notes.first == key_notes.last)
					key_notes.pop
				else
					raise BadScalePattern.new("scale doesn't end on same note as key!!")
				end

				return key_notes
			end


			# Translate a series of 'h', 'w', 'wh' and 'ww' strings to their
			# respective number of half steps.
			def find_scale_intervals(pattern)
				n = 0
				[ 0 ] + find_scale_pattern(pattern).collect do |offset|
					n += case offset
						when 'h'
							1
						when 'w'
							2
						when 'wh'
							3
						when 'ww'
							4
					end
				end
			end


			# Returns the index to NOTES for the note c.
			def find_note_from_char(c)
				NOTES.index(c) or
					raise BadNote.new(c)
			end


			# Returns the value from NOTES for the index i.
			def find_note_from_index(i)
				NOTES[((i.to_i).modulo(NOTES.length))] or
					raise BadNote.new(i)
			end

			# Figure out what notes are in a chord based on the key and the
			# chord type.
			#
			# * key is one of the notes from NOTES
			# * type is a chord type from CHORD_TYPES or an Array of integers
			#   representing intervals.
			def find_chord_notes(key, type)
				start = find_note_from_char(key)

				find_chord_type(type).collect do |v|
					find_note_from_index(start + v.to_i)
				end
			end


			# Used by some interval lookup methods to possibly convert string
			# notes to intervals where necessary.
			def interval_or_note_to_interval(key, interval)
				key = find_note_from_char(key) if key.is_a?(String)

				case interval
					when String
						(NOTES.index(interval) - key).modulo(NOTES.length)
					when Fixnum
						interval
					else
						raise BadNote.new(v)
				end
			end


			# Find intervals between notes in a chord or on a scale. Returns an
			# Array of Arrays where the internal Arrays are set up as
			# [ note, interval name ] in order starting with the tonic.
			#
			# * root is the tonic, a note from NOTES
			# * notes is an Array of notes
			def find_intervals(root, notes = NOTES)
				start = find_note_from_char(root)
				retval = Array.new
				notes.to_a.each do |v|
					n = interval_or_note_to_interval(start, v)
					name = case n
						when 0
							'tonic'
						when 1
							'minor second'
						when 2
							'major second'
						when 3
							'minor third'
						when 4
							'major third'
						when 5
							'fourth'
						when 6
							'diminished fifth'
						when 7
							'perfect fifth'
						when 8
							'minor sixth'
						when 9
							'major sixth'
						when 10
							'minor seventh'
						when 11
							'major seventh'
						else
							raise BadIntervalName.new(v)
					end

					retval << [
						(v.is_a?(String) ?
							v :
							find_note_from_index(v + start)
						),
						name
					]
				end

				# Sort and re-order the Array so the tonic is at the beginning.
				retval.sort!
				unless retval.detect { |x| x[0] == root }
					raise "root note not found in retval, this can't be good"
				else
					retval << retval.shift until retval.first[0] == root
				end

				return retval
			end


			# Find numerical symbols of an interval based on the root
			#
			# * root is the tonic, a note from NOTES
			# * notes an Array of notes
			def find_symbols(root, notes = NOTES)
				start = find_note_from_char(root)
				retval = Array.new
				notes.to_a.each do |v|
					n = interval_or_note_to_interval(start, v)
					symbol = case n
						when 0
							'I'
						when 1
							'ii'
						when 2
							'II'
						when 3
							'iii'
						when 4
							'III'
						when 5
							'IV'
						when 6
							'IV+ or V'
						when 7
							'V'
						when 8
							'V+ or vi'
						when 9
							'VI or viiº'
						when 10
							'vii'
						when 11
							'VII'
					end

					retval << [
						(v.is_a?(String) ?
							v :
							find_note_from_index(v + start)
						),
						symbol
					]
				end

				# Sort and re-order the Array so the tonic is at the beginning.
				retval.sort!
				unless retval.detect { |x| x[0] == root }
					raise "root note not found in retval, this can't be good"
				else
					retval << retval.shift until retval.first[0] == root
				end

				return retval
			end


			# Find numerical symbols of an interval based on the root
			#
			# * root is the tonic, a note from NOTES
			# * notes an Array of notes
			def find_single_symbols(root, notes = NOTES)
				start = find_note_from_char(root)
				retval = Array.new
				notes.to_a.each do |v|
					n = interval_or_note_to_interval(start, v)
					symbol = case n
						when 0
							'I'
						when 1
							'ii'
						when 2
							'II'
						when 3
							'iii'
						when 4
							'III'
						when 5
							'IV'
						when 6
							'IV+'
						when 7
							'V'
						when 8
							'vi'
						when 9
							'VI'
						when 10
							'vii'
						when 11
							'VII'
					end

					retval << [
						(v.is_a?(String) ?
							v :
							find_note_from_index(v + start)
						),
						symbol
					]
				end

				# Sort and re-order the Array so the tonic is at the beginning.
				retval.sort!
				unless retval.detect { |x| x[0] == root }
					raise "root note not found in retval, this can't be good"
				else
					retval << retval.shift until retval.first[0] == root
				end

				return retval
			end


			# Find the degree of an interval based on the root
			#
			# * root is the tonic, a note from NOTES
			# * notes is an Array of notes
			def find_degrees(root, notes = NOTES)
				start = find_note_from_char(root)
				retval = Array.new
				notes.to_a.each do |v|
					n = interval_or_note_to_interval(start, v)
					degree = case n
						when 0
							'tonic'
						when 1, 2
							'super tonic'
						when 3, 4
							'mediant'
						when 5
							'subdominant'
						when 6
							'tritone'
						when 7
							'dominant'
						when 8, 9
							'sub mediant'
						when 10
							'sub tonic'
						when 11
							'leading note'
					end

					retval << [
						(v.is_a?(String) ?
							v :
							find_note_from_index(v + start)
						),
						degree
					]
				end

				# Sort and re-order the Array so the tonic is at the beginning.
				retval.sort!
				unless retval.detect { |x| x[0] == root }
					raise "root note not found in retval, this can't be good"
				else
					retval << retval.shift until retval.first[0] == root
				end

				return retval
			end


			# Find the sound characteristic of an interval based on the root
			#
			# * root is the tonic, a note from NOTES
			# * notes is an Array of notes
			def find_characteristics(root, notes = NOTES)
				start = find_note_from_char(root)
				retval = Array.new
				notes.to_a.each do |v|
					n = interval_or_note_to_interval(start, v)
					characteristic = case n
						when 0
							'open consonance'
						when 1
							'sharp dissonance'
						when 2
							'mild dissonance'
						when 3, 4
							'soft consonance'
						when 5
							'consonance or dissonance'
						when 6
							'neutral or restless'
						when 7
							'open consonance'
						when 8, 9
							'soft consonance'
						when 10
							'mild dissonance'
						when 11
							'sharp dissonance'
					end

					retval << [
						(v.is_a?(String) ?
							v :
							find_note_from_index(v + start)
						),
						characteristic
					]
				end

				# Sort and re-order the Array so the tonic is at the beginning.
				retval.sort!
				unless retval.detect { |x| x[0] == root }
					raise "root note not found in retval, this can't be good"
				else
					retval << retval.shift until retval.first[0] == root
				end

				return retval
			end


			# Converts the name of the interval to a suitable HTML class.
			def interval_to_html_class(intervals, note)
				note = find_note_from_index(note) if note.is_a?(Fixnum)

				if klass = intervals.detect { |x| x[0] == note }
					klass.last.gsub(/[^a-z]/, '-')
				else
					nil
				end
			end


			# Converts an interval's class name to a CSS style.
			def interval_class_to_style(klass)
				INTERVAL_CSS_STYLES[klass.to_sym].join(' ')
			end


			# Converts an interval to a CSS style.
			def interval_to_html_style(intervals, note)
				if klass = interval_to_html_class(intervals, note)
					interval_class_to_style(klass)
				else
					nil
				end
			end


			# Figures out the shortest distance between notes x and y without
			# regard to which note is higher in pitch.
			def shortest_distance(x, y)
				x = find_note_from_char(x) unless x.is_a?(Fixnum)
				y = find_note_from_char(y) unless y.is_a?(Fixnum)
				z = x - y

				# Use the shortest distance between the notes. If
				# it's less than half the size of NOTES, then we wrap
				# around to the other side.
				if z >= 0
					if z.abs < (NOTES.length / 2)
						z
					else
						z - 12
					end
				else
					if z.abs < (NOTES.length / 2)
						z
					else
						z + 12
					end
				end
			end

			# Figures out the distance between the low note and the high note.
			def low_to_high_distance(low, high)
				low = find_note_from_char(low) unless low.is_a?(Fixnum)
				high = find_note_from_char(high) unless high.is_a?(Fixnum)
				z = high - low

				if z >= 0
					z
				else
					z + 12
				end
			end
		end

		self.extend(InstanceMethods)
	end
end

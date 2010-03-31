
require 'music/keyboard/diagrams'

class Music::Keyboard::Chord
	include Music::Keyboard::Diagrams

	attr_reader :key, :type, :notes, :intervals

	# * key is the key of the chord, from NOTES.
	#
	# The only option at the moment is :type, which would be one of
	# the chord types from CHORD_TYPES. You can also use an Array of
	# intervals if you wish. See find_chord_notes for details.
	def initialize key, type, options = {}
		options = {
		}.merge options

		@key = key
		@type = find_chord_type(type)
		@notes = find_chord_notes(@key, @type)
		@intervals = find_intervals(@key, @notes)
	end
end

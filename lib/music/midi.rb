
begin
	require 'midilib'
rescue Exception
end

require 'music'

module Music
	module Midi
		class MidiException < MusicException; end
		class MidilibMissing < MidiException; end

		MIDI_SCALE = 0
		MIDI_CHORD = 1

		def to_midi options = {}
			options = {
				:notes => nil,
				:instrument => 'Acoustic Grand Piano',
				:strum => false,
				:key => nil
			}.merge options

			midi_type = case self.class.to_s
				when /::Scale$/
					MIDI_SCALE
				when /::Chord$/
					MIDI_CHORD
				else
					raise MidiException, "not really sure what to do at this point"
			end

			if !MIDI::GM_PATCH_NAMES.index(options[:instrument])
				raise MidiException, "can't find instrument '#{options[:instrument]}' in GM_PATCH_NAMES"
			end

			start = find_note_from_char(options[:key] || @key)

			if options[:notes]
				midi_notes = options[:notes]
			else
				midi_notes = case midi_type
					when MIDI_SCALE
						find_scale_intervals(@pattern)
					when MIDI_CHORD
						find_chord_type(@type)
				end
			end

			if defined? MIDI
				seq = MIDI::Sequence.new

				# The first track sets up the tempo and such.
				track = MIDI::Track.new seq
				seq.tracks << track
				track.events << MIDI::Tempo.new(MIDI::Tempo.bpm_to_mpq(120))
				track.events << MIDI::MetaEvent.new(MIDI::META_SEQ_NAME, 'Sequence Name')

				# This next track will hold our notes.
				track = MIDI::Track.new(seq)
				seq.tracks << track
				track.name = 'My New Track'
				track.instrument = options[:instrument]
				track.events << MIDI::Controller.new(0, MIDI::CC_VOLUME, 127)

				# Change to a piano bank.
				track.events << MIDI::ProgramChange.new(0, MIDI::GM_PATCH_NAMES.index(options[:instrument]), 0)

				# Quarter note length.
				qn = seq.note_to_delta('quarter')

				# This first little section plays each note individually.
				current_time = qn
				midi_notes.each do |offset|
					offset = start + offset
					e1 = MIDI::NoteOnEvent.new(0, 45 + offset, 127, 0)
					e2 = MIDI::NoteOffEvent.new(0, 45 + offset, 127, qn)
					e1.time_from_start = current_time
					e2.time_from_start = current_time + qn
					track.events << e1
					track.events << e2
					current_time += qn
				end

				if midi_type == MIDI_CHORD
					# This section plays the notes together. If options[:strum]
					# is set then we include a little delay between each note
					# in the chord to simulate the strumming action.
					if options[:strum]
						strum = 80
					else
						strum = 0
					end

					midi_notes.each_with_index do |offset, i|
						offset = start + offset
						e1 = MIDI::NoteOnEvent.new(0, 45 + offset, 127, 0)
						e2 = MIDI::NoteOffEvent.new(0, 45 + offset, 127, qn)
						e1.time_from_start = current_time + qn  + (strum * i)
						e2.time_from_start = current_time + (2 * qn)  + (strum * i)
						track.events << e1
						track.events << e2
					end
				end

				track.recalc_delta_from_times

				# We'll return the entire sequence as a MIDI::Seq object.
				return seq
			else
				raise MidilibMissing, "Can't find midilib extension"
			end
		end
	end
end

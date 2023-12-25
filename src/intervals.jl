

@enum IntervalQuality Perfect Augmented Diminished Major Minor

# distance is 0 for unison, 1 for second, etc.
# so is 7 for octave, 8 for ninth, etc.
struct Interval
    distance::Int
    quality::IntervalQuality
end

interval(distance, quality) = Interval(distance - 1, quality)

function interval_name(distance::Int)
    if distance == 0
        return "unison"
    elseif distance == 1
        return "2nd"
    elseif distance == 2
        return "3rd"
    elseif distance == 7
        return "octave"
    else
        return string(distance + 1, "th")
    end
end

Base.show(io::IO, interval::Interval) =
    print(io, interval.quality, " ", interval_name(interval.distance))


interval_semitones =
    Dict(0 => 0, 1 => 2, 2 => 4, 3 => 5, 4 => 7, 5 => 9, 6 => 11)

interval_quality_semitones = Dict(
    Perfect => 0,
    Augmented => +1,
    Diminished => -1,
    Major => 0,
    Minor => -1
)

semitone(interval::Interval) =
    interval_semitones[interval.distance] + interval_quality_semitones[interval.quality]

Base.:(<=)(n1::Pitch, n2::Pitch) = M.semitone(n1) <= M.semitone(n2)



# interval between two pitches:
function interval(n1::Pitch, n2::Pitch)
    if n2 <= n1
        n1, n2 = n2, n1
    end

    note_distance = Int(n2.note.noteclass) - Int(n1.note.noteclass)

    octave_distance = 7 * (n2.octave - n1.octave)

    total_note_distance = note_distance + octave_distance

    semitone_distance = (M.semitone(n2) - M.semitone(n1)) % 12

    base_interval_semitone = interval_semitones[total_note_distance %7]
    alteration_distance = semitone_distance - base_interval_semitone



    @show note_distance, total_note_distance, semitone_distance, base_interval_semitone, alteration_distance

    if abs(note_distance) + 1 ∈ (1, 4, 5)
        if alteration_distance == 0
            return Interval(total_note_distance, Perfect)
        elseif alteration_distance >= 1
            return Interval(total_note_distance, Augmented)
        elseif alteration_distance <= -1
            return Interval(total_note_distance, Diminished)
        end
    else
        if alteration_distance == 0
            return Interval(total_note_distance, Major)
        elseif alteration_distance == -1
            return Interval(total_note_distance, Minor)
        elseif alteration_distance > 0
            return Interval(total_note_distance, Augmented)
        elseif alteration_distance < -1
            return Interval(total_note_distance, Diminished)
        end
    end
end


tone(interval::Interval) = interval.distance

semitone(interval::Interval) = 
    interval_semitones[interval.distance] + interval_quality_semitones[interval.quality]

function add_interval(p::Pitch, interval::Interval)
    new_tone = tone(p) + tone(interval)

    new_note_class = NoteClass(new_tone % 7)
    new_octave = new_tone ÷ 7

    new_semitone = semitone(p) + semitone(interval)
    new_note = find_accidental(new_semitone % 12, new_note_class)

    new_pitch = Pitch(new_note, new_octave)

    return new_pitch
end

Base.:(+)(p::Pitch, interval::Interval) = add_interval(p, interval)

const Minor_2nd = Interval(1, Minor)
const Major_2nd = Interval(1, Major)

const Major_3rd = Interval(2, Major)
const Major_3rd = Interval(2, Major)
const Perfect_4th = Interval(3, Perfect)


# add_interval(M.C4, Interval(2, Minor))
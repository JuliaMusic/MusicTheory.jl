

@enum IntervalQuality Perfect Augmented Diminished Major Minor

# number is 1 for unison, 2 for second, etc.
struct Interval
    number::Int
    quality::IntervalQuality
end

# interval(distance, quality) = Interval(distance - 1, quality)

function interval_name(number::Int)
    if number == 1
        return "unison"
    elseif number == 2
        return "2nd"
    elseif number == 3
        return "3rd"
    elseif number == 8
        return "octave"
    else
        return string(number, "th")
    end
end

Base.show(io::IO, interval::Interval) =
    print(io, interval.quality, " ", interval_name(interval.number))


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
    interval_semitones[interval.number - 1] + interval_quality_semitones[interval.quality]

tone(interval::Interval) = interval.number - 1  # distance


# interval between two pitches:
function Interval(n1::Pitch, n2::Pitch)
    if n2 <= n1
        n1, n2 = n2, n1
    end

    note_distance = tone(n2.class) - tone(n1.class)

    octave_distance = 7 * (n2.octave - n1.octave)

    total_note_distance = note_distance + octave_distance

    semitone_distance = (semitone(n2) - semitone(n1)) % 12

    base_interval_semitone = interval_semitones[total_note_distance % 7]
    alteration_distance = semitone_distance - base_interval_semitone

    total_note_distance += 1

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

Interval( (n1, n2) ) = Interval(n1, n2)


function Base.:+(n::PitchClass, interval::Interval)
    new_tone = (tone(n) + tone(interval)) % 7

    new_pitch_class = note_names[new_tone + 1]
    new_octave = new_tone ÷ 7

    new_semitone = semitone(n) + semitone(interval)
    new_note = find_accidental(new_semitone % 12, new_pitch_class)

    return new_note
end


function Base.:+(p::Pitch, interval::Interval)
    new_tone = tone(p) + tone(interval)
    new_octave = new_tone ÷ 7

    new_note = p.class + interval
    new_pitch = Pitch(new_note, new_octave)

    return new_pitch
end


const Minor_2nd = Interval(2, Minor)
const Major_2nd = Interval(2, Major)

const Major_3rd = Interval(3, Major)
const Major_3rd = Interval(3, Major)
const Perfect_4th = Interval(4, Perfect)

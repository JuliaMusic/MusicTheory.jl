
# mappings from note names to semitones:
const note_names = [:C, :D, :E, :F, :G, :A, :B]
const note_semitones = Dict(:C => 0, :D => 2, :E => 4, :F => 5, :G => 7, :A => 9, :B => 11)
const note_to_tone = Dict(v => k for (k, v) in enumerate(note_names))

## Accidentals
@enum Accidental 𝄫 ♭ ♮ ♯ 𝄪
const accidental_semitones = Dict(𝄫 => -2, ♭ => -1, ♮ => 0, ♯ => 1, 𝄪 => 2)
const semitone_to_accidental = Dict(v => k for (k, v) in accidental_semitones)



struct PitchClass
    name::Symbol
    accidental::Accidental
end

# default is natural:
PitchClass(name::Symbol) = PitchClass(name, ♮)
# Base.convert(::Type{PitchClass}, noteclass::NoteNames) = PitchClass(noteclass, ♮)

subscript(i::Int) = '₀' + i

"Scientific pitch notation, e.g. C4"
struct Pitch
    class::PitchClass
    octave::Int
end

function Base.show(io::IO, class::PitchClass)
    if class.accidental == ♮
        print(io, class.name)
    else
        print(io, class.name, class.accidental)
    end
end

Base.show(io::IO, pitch::Pitch) =
    print(io, pitch.class, subscript(pitch.octave))

Base.getindex(class::PitchClass, i::Int) = Pitch(class, i)


octave(pitch::Pitch) = pitch.octave

tone(note::Symbol) = note_to_tone[note]
tone(note::PitchClass) = tone(note.classclass)
tone(pitch::Pitch) = tone(pitch.class) + 7 * pitch.octave


## Semitones
semitone(accidental::Accidental) = accidental_semitones[accidental]
semitone(note::Symbol) = note_semitones[note]

semitone(note::PitchClass) = semitone(note.classclass) + semitone(note.accidental)

"Treats C0 as semitone 0"
semitone(pitch::Pitch) = semitone(pitch.class) + 12 * pitch.octave

PitchClass(pitch::Pitch) = pitch.class


function find_accidental(which_semitone, noteclass)
    basic_semitone = semitone(noteclass)

    distance = which_semitone - basic_semitone
    if abs(distance) > 2
        distance = mod(distance, 12)  # wrap round
    end

    accidental = semitone_to_accidental[distance]

    return PitchClass(noteclass, accidental)
end

PitchClass(n::PitchClass) = n



Base.isless(n1::Pitch, n2::Pitch) = semitone(n1) < semitone(n2)




# define Julia objects for pitch classes:

module NoteNames

using MusicTheory
using MusicTheory: note_names

export
    C, D, E, F, G, A, B,
    C♮, D♮, E♮, F♮, G♮, A♮, B♮,
    C♯, D♯, E♯, F♯, G♯, A♯, B♯,
    C♭, D♭, E♭, F♭, G♭, A♭, B♭,
    C𝄫, D𝄫, E𝄫, F𝄫, G𝄫, A𝄫, B𝄫,
    C𝄪, D𝄪, E𝄪, F𝄪, G𝄪, A𝄪, B𝄪,
    middle_C

for name in note_names, accidental in instances(Accidental)
    note = Symbol(name, accidental)

    @eval $(note) = PitchClass($(Meta.quot(name)), $(accidental))

    if accidental == ♮
        @eval $(Symbol(name)) = PitchClass($(Meta.quot(name)), $(accidental))
    end
end

const middle_C = C[4]


end
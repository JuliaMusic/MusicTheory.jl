
# mappings from note names to semitones:
const note_semitones = Dict(:C => 0, :D => 2, :E => 4, :F => 5, :G => 7, :A => 9, :B => 11)

## Accidentals
@enum Accidental 𝄫 ♭ ♮ ♯ 𝄪
const accidental_semitones = Dict(𝄫 => -2, ♭ => -1, ♮ => 0, ♯ => 1, 𝄪 => 2)
const semitone_to_accidental = Dict(v => k for (k, v) in accidental_semitones)


## PitchClasss
struct PitchClass
    name::Symbol
    accidental::Accidental
end

# default is natural:
# PitchClass(noteclass::NoteNames) = PitchClass(noteclass, ♮)
# Base.convert(::Type{PitchClass}, noteclass::NoteNames) = PitchClass(noteclass, ♮)

Base.show(io::IO, note::PitchClass) = print(io, note.class, note.accidental)

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

Base.show(io::IO, pitch::Pitch) = print(io, pitch.class, pitch.octave)
   
PitchClass(C, ♮)

Base.:*(note::NoteNames, accidental::Accidental) = PitchClass(note, accidental)

for note in instances(NoteNames), accidental in instances(Accidental)
    name = Symbol(note, accidental)

    @eval $(name) = $(note) * $(accidental)
end


for note in instances(NoteNames), octave in 0:8
    name = Symbol(note, octave)
    @eval $(name) = Pitch($(note), $(octave))

    for accidental in instances(Accidental)
        name = Symbol(note, accidental, octave)
        @eval $(name) = Pitch(PitchClass($(note), $(accidental)), $(octave))
    end
end

octave(pitch::Pitch) = pitch.octave

tone(note::NoteNames) = Int(note)
tone(note::PitchClass) = tone(note.classclass)
tone(pitch::Pitch) = tone(pitch.class) + 7 * pitch.octave


## Semitones
semitone(accidental::Accidental) = accidental_semitones[accidental]
semitone(note::NoteNames) = note_semitones[note]

semitone(note::PitchClass) = semitone(note.classclass) + semitone(note.accidental)

"Treats C0 as semitone 0"
semitone(pitch::Pitch) = semitone(pitch.class) + 12 * pitch.octave

NoteNames(pitch::Pitch) = pitch.class.classclass
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

const middle_C = C4


Base.isless(n1::Pitch, n2::Pitch) = semitone(n1) < semitone(n2)



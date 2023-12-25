
# often called a "pitch class"
@enum NoteClass C=0 D E F G A B

const note_names = instances(NoteClass)
const scale_grades = Dict(name => value - 1 for (value, name) in enumerate(note_names))

# mappings from note names to semitones:
const note_semitones = Dict(C => 0, D => 2, E => 4, F => 5, G => 7, A => 9, B => 11)
const semitone_to_note = Dict(v => k for (k, v) in note_semitones)


## Accidentals
@enum Accidental 𝄫 ♭ ♮ ♯ 𝄪
const accidental_semitones = Dict(𝄫 => -2, ♭ => -1, ♮ => 0, ♯ => 1, 𝄪 => 2)
const semitone_to_accidental = Dict(v => k for (k, v) in accidental_semitones)


## Notes
struct Note
    noteclass::NoteClass
    accidental::Accidental
end

# default is natural:
Note(noteclass::NoteClass) = Note(noteclass, ♮)
Base.convert(::Type{Note}, noteclass::NoteClass) = Note(noteclass, ♮)

Base.show(io::IO, note::Note) = print(io, note.noteclass, note.accidental)

"Scientific pitch notation, e.g. C4"
struct Pitch
    note::Note
    octave::Int
end

function Base.show(io::IO, pitch::Pitch)
    if pitch.note.accidental == ♮
        print(io, pitch.note.noteclass, pitch.octave)
    else
        print(io, pitch.note, pitch.octave)
    end
end

Note(C, ♮)

Base.:*(note::NoteClass, accidental::Accidental) = Note(note, accidental)

for note in instances(NoteClass), accidental in instances(Accidental)
    name = Symbol(note, accidental)

    @eval $(name) = $(note) * $(accidental)
end


for note in instances(NoteClass), octave in 0:8
    name = Symbol(note, octave)
    @eval $(name) = Pitch($(note), $(octave))

    for accidental in instances(Accidental)
        name = Symbol(note, accidental, octave)
        @eval $(name) = Pitch(Note($(note), $(accidental)), $(octave))
    end
end

octave(pitch::Pitch) = pitch.octave

tone(note::NoteClass) = Int(note)
tone(note::Note) = tone(note.noteclass)
tone(pitch::Pitch) = tone(pitch.note) + 7 * pitch.octave


## Semitones
semitone(accidental::Accidental) = accidental_semitones[accidental]
semitone(note::NoteClass) = note_semitones[note]

semitone(note::Note) = semitone(note.noteclass) + semitone(note.accidental)

semitone(pitch::Pitch) = semitone(pitch.note) + 12 * pitch.octave

NoteClass(pitch::Pitch) = pitch.note.noteclass
Note(pitch::Pitch) = pitch.note

"Treats C0 as semitone 0"
function semitone(pitch::Pitch)
    return semitone(pitch.note) + 12*pitch.octave
end


function find_accidental(which_semitone, noteclass)
    basic_semitone = semitone(noteclass)

    distance = which_semitone - basic_semitone
    if abs(distance) > 2
        distance = mod(distance, 12)  # wrap round
    end

    accidental = semitone_to_accidental[distance]

    return Note(noteclass, accidental)
end


const middle_C = C4

semitone(middle_C) 
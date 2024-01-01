
struct Rest end

const NoteTypes = Union{Pitch, Chord{Pitch}, Rest}

"""
    struct Note

A note is a pitch and a duration.
The pitch can be a chord, or a rest
"""
struct Note
    pitch::NoteTypes
    duration::Rational{Int}
end

# use / and * to specify durations:
Base.:(/)(p::NoteTypes, n::Int) = Note(p, 1 // n)
Base.:(*)(p::NoteTypes, n::Rational{Int}) = Note(p, n)

const rest = Rest()



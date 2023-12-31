

# const Chord{T <: Union{PitchClass, Pitch}} = Set{T}

struct Chord{T <: Union{PitchClass, Pitch}}
    notes::Set{T}
end

Chord(notes::T...) where {T <: Union{PitchClass, Pitch}} = Chord{T}(Set(notes))


Base.length(chord::Chord) = length(chord.notes)
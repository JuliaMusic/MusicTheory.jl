module MusicTheory

export Pitch, Note, Accidental, NoteClass,
    MajorScale, MinorScale,
    𝄫, ♭, ♮, ♯, 𝄪, C, D, E, F, G, A, B, C♮, D♮, E♮, F♮, G♮, A♮, B♮, C♯, D♯, E♯, F♯, G♯, A♯,
    B♯, C♭, D♭, E♭, F♭, G♭, A♭, B♭, C𝄫, D𝄫, E𝄫, F𝄫, G𝄫, A𝄫, B𝄫, C𝄪, D𝄪, E𝄪, F𝄪, G,
    note_names

export Interval, IntervalType, Major, Minor, Perfect, Augmented, Diminished,
    add_interval, tone, semitone

include("notes.jl")
include("intervals.jl")

end

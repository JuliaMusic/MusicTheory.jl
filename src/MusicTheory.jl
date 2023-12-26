module MusicTheory

export Pitch, Note, Accidental, NoteClass,
    𝄫, ♭, ♮, ♯, 𝄪, C, D, E, F, G, A, B, C♮, D♮, E♮, F♮, G♮, A♮, B♮, C♯, D♯, E♯, F♯, G♯, A♯,
    B♯, C♭, D♭, E♭, F♭, G♭, A♭, B♭, C𝄫, D𝄫, E𝄫, F𝄫, G𝄫, A𝄫, B𝄫, C𝄪, D𝄪, E𝄪, F𝄪, G,
    note_names

export Interval, IntervalType, Major, Minor, Perfect, Augmented, Diminished,
    add_interval, tone, semitone, interval

export Major_2nd, Minor_2nd, Major_3rd, Minor_3rd, Perfect_4th, Perfect_5th,
    Major_6th, Minor_6th, Major_7th, Minor_7th, Octave

export Scale
export major_scale, natural_minor_scale, melodic_minor_scale, harmonic_minor_scale



include("notes.jl")
include("intervals.jl")
include("scales.jl")
end

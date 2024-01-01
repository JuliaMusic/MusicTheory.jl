module MusicTheory

export Pitch, PitchClass, Accidental, PitchNames
export ♮, ♯, ♭, 𝄪, 𝄫
export accidental, octave

export Interval, IntervalType, Major, Minor, Perfect, Augmented, Diminished,
    add_interval, tone, semitone, interval

export Major_2nd, Minor_2nd, Major_3rd, Minor_3rd, Perfect_4th, Perfect_5th,
    Major_6th, Minor_6th, Major_7th, Minor_7th, Octave

export Scale
export major_scale, natural_minor_scale, melodic_minor_scale, harmonic_minor_scale

export Chord

export make_triad, is_triad

export Note, rest


include("pitches.jl")
include("pitch_names.jl")
include("intervals.jl")
include("scales.jl")
include("chords.jl")
include("triads.jl")
include("notes.jl")
end


module PitchNames

using MusicTheory:
    C, D, E, F, G, A, B,
    C♮, D♮, E♮, F♮, G♮, A♮, B♮,
    C♯, D♯, E♯, F♯, G♯, A♯, B♯,
    C♭, D♭, E♭, F♭, G♭, A♭, B♭,
    C𝄫, D𝄫, E𝄫, F𝄫, G𝄫, A𝄫, B𝄫,
    C𝄪, D𝄪, E𝄪, F𝄪, G𝄪, A𝄪, B𝄪

export
    C, D, E, F, G, A, B,
    C♮, D♮, E♮, F♮, G♮, A♮, B♮,
    C♯, D♯, E♯, F♯, G♯, A♯, B♯,
    C♭, D♭, E♭, F♭, G♭, A♭, B♭,
    C𝄫, D𝄫, E𝄫, F𝄫, G𝄫, A𝄫, B𝄫,
    C𝄪, D𝄪, E𝄪, F𝄪, G𝄪, A𝄪, B𝄪,
    middle_C

const middle_C = C[4]

end


module AllPitchNames

using MusicTheory: note_names, Pitch, PitchClass, Accidental

using MusicTheory.PitchNames

for note in note_names, octave in 0:9
    name = Symbol(note, octave)
    @eval $(name) = Pitch(PitchClass($(Meta.quot(note))), $(octave))
    @eval export $(name)

    for accidental in instances(Accidental)
        name = Symbol(note, accidental, octave)
        @eval $(name) = Pitch(PitchClass($(Meta.quot(note)), $(accidental)), $(octave))
        @eval export $(name)
    end
end

end
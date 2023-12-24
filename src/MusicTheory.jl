module MusicTheory

export Pitch, Note, Accidental, NoteClass, Interval, IntervalType, 
    MajorScale, MinorScale, Major, Minor, Perfect, Augmented, Diminished, 
    𝄫, ♭, ♮, ♯, 𝄪, C, D, E, F, G, A, B, C♮, D♮, E♮, F♮, G♮, A♮, B♮, C♯, D♯, E♯, F♯, G♯, A♯, 
    B♯, C♭, D♭, E♭, F♭, G♭, A♭, B♭, C𝄫, D𝄫, E𝄫, F𝄫, G𝄫, A𝄫, B𝄫, C𝄪, D𝄪, E𝄪, F𝄪, G,
    note_names
 

# export all identifiers in this module:
for n in names(@__MODULE__; all=true)♮
    if Base.isidentifier(n) && n ∉ (Symbol(@__MODULE__), :eval, :include)
        @eval export $n
    end
end

include("notes.jl")
include("intervals.jl")

end

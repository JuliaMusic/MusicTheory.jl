function make_triad(scale::Scale, root::Pitch)

    !haskey(scale.steps, PitchClass(root)) && error("$root not in scale")

    triad_notes = [root]

    current, next = iterate(scale, root)
    current, next = iterate(scale, next)

    push!(triad_notes, next)

    current, next = iterate(scale, next)
    current, next = iterate(scale, next)

    push!(triad_notes, next)

    return Chord(triad_notes...)
end


function find_intervals(chord)
    notes = sort(collect(chord.notes))
    # return [interval(n1, n2) for n1 in notes for n2 in notes if n1 < n2]
    return [Interval(notes[1], notes[2]), Interval(notes[1], notes[3])]
end


function is_triad(chord::Chord{PitchClass})
    length(chord) != 3 && return false

    # put them in the same octave:
    pitches = [Pitch(n, 4) for n in chord.notes]

    intervals = find_intervals(Chord(pitches...)) |> collect
    numbers = (intervals[1].number, intervals[2].number)

    return numbers ∈ ( (3, 5), (3, 6), (4, 6) )
end

is_triad(chord::Chord{Pitch}) = is_triad(Chord(PitchClass.(chord.notes)...))

is_triad(notes...) = is_triad(Chord(notes...))
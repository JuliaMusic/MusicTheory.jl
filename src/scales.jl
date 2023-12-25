

mutable struct Scale
    current::Pitch
    steps
end

# state is a counter that loops through the steps vector
function next_state(s::Scale, state)
    if state == length(s.steps)
        state = 1
    else
        state += 1
    end

    return state
end

function next_value!(s::Scale, state)
    s.current = s.current + s.steps[state]
    return s.current
end

Scale(state, steps) = Scale(state, steps, 1)

Base.IteratorSize(::Type{Scale}) = Base.IsInfinite()
Base.IteratorEltype(::Type{Scale}) = Base.HasEltype()
Base.eltype(::Type{Scale}) = Pitch

function iterate!(s::Scale, state)
    next_value!(s, state)
    state = next_state(s, state)

    return state
end

function Base.iterate(s::Scale, state=1)
    current = s.current
    state = iterate!(s, state)

    return current, state
end


major_scale = let M = Major_2nd, m = Minor_2nd
    [M, M, m, M, M, M, m]
end

natural_minor_scale = let M = Major_2nd, m = Minor_2nd
[M, m, M, M, M, m, M]
end

melodic_minor_scale = let M = Major_2nd, m = Minor_2nd
[M, m, M, M, M, M, m]
end

harmonic_minor_scale = let M = Major_2nd, m = Minor_2nd
[M, m, M, M, m, Interval(1, Augmented), m]
end


s = Scale(MusicTheory.C4, major_scale)

s

s = Base.Iterators.Stateful(Scale(MusicTheory.C4, major_scale))

popfirst!(s)

Iterators.take(s, 10) |> collect

s2 = Base.Iterators.Stateful(Scale(MusicTheory.C4, harmonic_minor_scale))

Base.Iterators.take(s2, 10) |> collect

eltype(Scale)


@edit Base.Iterators.Stateful(Scale(MusicTheory.C4, major_scale))
struct Scale{T<:Union{PitchClass, Pitch}}
    tonic::T
    steps::Dict{PitchClass, Interval}

    function Scale(tonic::T, steps::Vector{Interval}) where {T}
        steps_dict = Dict{PitchClass, Interval}()

        current = tonic
        for step in steps
            steps_dict[PitchClass(current)] = step
            current += step
        end

        return new{T}(tonic, steps_dict)
    end
end


function Base.iterate(s::Scale{T}, p::T = s.tonic) where {T <: Union{PitchClass, Pitch}}
    n = PitchClass(p)

    !haskey(s.steps, n) && error("PitchClass $n not in scale")

    step = s.steps[n]  # an interval
    new_p = p + step  # a note or a pitch, according to the type of p

    return (p, new_p)
end

Base.IteratorSize(::Type{Scale{T}}) where {T} = Base.IsInfinite()
Base.IteratorEltype(::Type{Scale{T}}) where {T} = Base.HasEltype()
Base.eltype(::Type{Scale{T}}) where {T} = T


const major_scale = let M = Major_2nd, m = Minor_2nd
    [M, M, m, M, M, M, m]
end

const natural_minor_scale = let M = Major_2nd, m = Minor_2nd
    [M, m, M, M, M, m, M]
end

const melodic_minor_scale = let M = Major_2nd, m = Minor_2nd
    [M, m, M, M, M, M, m]
end

const harmonic_minor_scale = let M = Major_2nd, m = Minor_2nd
    [M, m, M, M, m, Interval(1, Augmented), m]
end


# s = Scale(MusicTheory.D4, major_scale)


# popfirst!(s)

# collect(Iterators.take(s, 20))

# s2 = Base.Iterators.Stateful(Scale(MusicTheory.C4, harmonic_minor_scale))

# Base.Iterators.take(s2, 10) |> collect

# eltype(Scale)


# # @edit Base.Iterators.Stateful(Scale(MusicTheory.C4, major_scale))


# interval(C4, B4)




# iterate(s)

const M = MusicTheory
# s = Scale(M.C4, major_scale)

# notes = Base.Iterators.take(s, 8) |> collect

# iterate(s, C4)

s = Scale(M.C♮4, melodic_minor_scale)

# makes thirds from scale tones:
notes = Base.Iterators.take(s, 10) |> collect

thirds = zip(notes, notes[3:end]) |> collect

thirds_intervals = interval.(thirds)
note_intervals = interval.(zip(notes, notes[2:end]))

all = []
for i in 1:(length(thirds)-1)
    push!(all, (note_intervals[i], thirds_intervals[i], thirds_intervals[i+1]))
end

all

1 |> collect




# repeating pattern: how many scale notes to increment for each subsequent note

arpeggio = [2, 2, 3]
# broken thirds = [2, -1]
# broken octaves = [7, -6]
# broken arpeggio = [4, -2, 5] 

# stateful iterator:
mutable struct Motif
    scale::Scale
    pattern::Vector{Int}
    current::Pitch
    i
end

Motif(scale, pattern) = Motif(scale, pattern, first(iterate(scale)), 1)

function Base.iterate(m::Motif)
    return_value = m.current
    current, next = iterate(scale)

    for i in 1:m.pattern[m.i] - 1
        current, next = iterate(scale, next)
    end

    m.i += 1
    if m.i > length(m.pattern)
        m.i = 1
    end

    m.current = current
    return return_value, next
end

function Base.iterate(m::Motif, next)

    return_value = next

    for i in 1:m.pattern[m.i]
        current, next = iterate(scale, next)
    end

    m.i += 1
    if m.i > length(m.pattern)
        m.i = 1
    end

    m.current = current

    return return_value, next
end


Base.IteratorSize(::Type{Motif}) = Base.IsInfinite()
Base.IteratorEltype(::Type{Motif}) = Base.HasEltype()
Base.eltype(::Type{Motif}) = Pitch


scale = Scale(M.C4, major_scale)
arpeggio = Motif(scale, [2, 2, 3])

# arpeggio

current, next = iterate(arpeggio)
current, next = iterate(arpeggio, next)
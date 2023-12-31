"""
    struct Scale{T<:Union{PitchClass, Pitch}}

A musical scale divides up an octave.
A scale is represented as an iterator.
"""
struct Scale{T<:Union{PitchClass, Pitch}}
    tonic::T
    steps::Dict{PitchClass, Interval}

    function Scale(tonic::T, steps::Vector{Interval}) where {T}

        # steps must add up to an octave:
        @assert sum(steps) == Interval(8, Perfect)

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
    [M, m, M, M, m, Interval(2, Augmented), m]
end






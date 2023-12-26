struct Scale{T<:Union{Note, Pitch}}
    tonic::T
    steps::Dict{Note, Interval}

    function Scale(tonic::T, steps::Vector{Interval}) where {T}
        steps_dict = Dict{Note, Interval}()

        current = tonic
        for step in steps
            steps_dict[Note(current)] = step
            current += step
        end

        return new{T}(tonic, steps_dict)
    end
end


function Base.iterate(s::Scale{T}, p::T = s.tonic) where {T <: Union{Note, Pitch}}
    n = Note(p)

    !haskey(s.steps, n) && error("Note $n not in scale")

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
s = Scale(M.C4, major_scale)

# notes = Base.Iterators.take(s, 8) |> collect

iterate(s, C4)
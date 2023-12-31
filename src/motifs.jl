
# A motif is a repeating pattern within a scale
# Specify by how many scale notes to increment for each subsequent note

arpeggio = [2, 2, 3]
# broken thirds = [2, -1]
# broken octaves = [7, -6]
# broken arpeggio = [4, -2, 5] 

# stateful iterator:
mutable struct Motif
    scale::Scale
    pattern::Vector{Int}
    current::Pitch
    i::Int
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

    m.current = return_value
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

    m.current = return_value

    return return_value, next
end


Base.IteratorSize(::Type{Motif}) = Base.IsInfinite()
Base.IteratorEltype(::Type{Motif}) = Base.HasEltype()
Base.eltype(::Type{Motif}) = Pitch

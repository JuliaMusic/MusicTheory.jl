# MusicTheory.jl

[![Build Status](https://github.com/dpsanders/MusicTheory.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/dpsanders/MusicTheory.jl/actions/workflows/CI.yml?query=branch%3Amain)

The goal of this package is to provide a Julian interface for representing
the objects and structures in ("Western") music theory (based on semitones).

## Contents of the package
- Pitches with scientific notation, e.g. C4 for middle C
- Intervals
- Scales
- Notes and rests with durations
- Chords 
- Triads

## Pitches
Pitch names are exported in the `MusicTheory.PitchNames` submodule.

Specifying just the name of a pitch gives a `PitchClass`, representing all notes of that
pitch, e.g.
```jl
julia> C♯
C♯

julia> typeof(C♯)
PitchClass
```

Indexing gives a pitch with a specific octave, e.g.
```jl
julia> C♯[4]
C♯₄
```

## Intervals
The `Interval` type computes the interval between two pitches:
```jl
julia> Interval(C[4], E[4])
Major 3rd

julia> C[4] + Interval(3, Major)
E₄
```

## Scales
General scales are supported; they are specified as a sequence of intervals dividing up an
octave, e.g.
```jl
julia> show(major_scale)
Interval[Major 2nd, Major 2nd, Minor 2nd, Major 2nd, Major 2nd, Major 2nd, Minor 2nd]
```

The `Scale` type is a standard Julia iterator over the scale:
```jl
julia> scale = Scale(C[4], major_scale)
Scale{Pitch}(C₄, Dict{PitchClass, Interval}(C => Major 2nd, E => Minor 2nd, B => Minor 2nd, F => Major 2nd, D => Major 2nd, G => Major 2nd, A => Major 2nd))

julia> scale_tones = Base.Iterators.take(scale, 8) |> collect;

julia> show(scale_tones)
Pitch[C₄, D₄, E₄, F₄, G₄, A₄, B₄, C₅]
```

## Notes
Notes have a pitch and a duration, which is a rational number, e.g. `1 // 4` for a
quarter note (crotchet). Rests are specified using `rest`, e.g.
```jl
julia> notes = [C[5] / 4, rest / 8, D[5] / 8]
3-element Vector{Note}:
 Note(C₅, 1//4)
 Note(MusicTheory.Rest(), 1//8)
 Note(D₅, 1//8)
```

## Example
A motivating example for writing this package was to be able to do the following types of
computations.

When playing the violin, it's common to have a scale in thirds: take a scale and for each
scale tone, play the note two steps above it in the scale at the same time.

Question: Which combinations of half/whole steps and pairs of major/minor thirds
are possible?

Answer:
```jl
julia> scale = Scale(C[4], major_scale)

julia> notes = Base.Iterators.take(scale, 10) |> collect

julia> thirds = zip(notes, notes[3:end]) |> collect

julia> thirds_intervals = Interval.(thirds)

julia> note_intervals = Interval.(zip(notes, notes[2:end]))

julia> combinations =
        [ (note_intervals[i], thirds_intervals[i], thirds_intervals[i+1])
            for i in 1:(length(thirds)-1)
        ]

julia> result = unique(combinations)
4-element Vector{Tuple{Interval, Interval, Interval}}:
 (Major 2nd, Major 3rd, Minor 3rd)
 (Major 2nd, Minor 3rd, Minor 3rd)
 (Minor 2nd, Minor 3rd, Major 3rd)
 (Major 2nd, Major 3rd, Major 3rd)
```

## TODO
- Play the notes
- Print the notes in standard notation, e.g. via an interface to Lilypond
- Interfaces with other packages

## Related packages
- [music21](https://web.mit.edu/music21/) (Python)
- [abjad](https://abjad.github.io/) (Python)
- [Haskore](https://wiki.haskell.org/Haskore) (Haskell)
- [Euterpea](https://www.euterpea.com/) (Haskell)
- [Supercollider](https://supercollider.github.io/)
- List of music packages on GitHub: https://github.com/topics/music-theory

## Author

I tried not to look at other packages, either in Julia or in other languages, while writing this.
Apologies for any duplication.

Copyright David P. Sanders, 2024

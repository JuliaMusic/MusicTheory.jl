# MusicTheory.jl

[![Build Status](https://github.com/dpsanders/MusicTheory.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/dpsanders/MusicTheory.jl/actions/workflows/CI.yml?query=branch%3Amain)

A Julia package for the basics of ("Western") music theory.
(Currently) everything is based on semitones.

## Contents
- Pitches with scientific notation, e.g. C4 for middle C
- Intervals
- Scales
- Chords
- Notes and rests with durations

## Pitches
Pitch names are exported in the `MusicTheory.PitchNames` submodule.

Specifying just the name of a pitch gives a `PitchClass`, representing all notes of that
pitch, e.g.
```
julia> C♯
C♯

julia> typeof(C♯)
PitchClass
```

Indexing gives a pitch with a specific octave, e.g.
```
julia> C♯[4]
C♯₄
```

## Intervals
The `Interval` type computes the interval between two pitches:
```
julia> Interval(C[4], E[4])
Major 3rd
```

## Scales
General scales are supported; they are specified as a sequence of intervals dividing up an
octave, e.g.
```
julia> show(major_scale)
Interval[Major 2nd, Major 2nd, Minor 2nd, Major 2nd, Major 2nd, Major 2nd, Minor 2nd]
```

The `Scale` type is a standard Julia iterator over the scale:
```
julia> scale = Scale(C[4], major_scale)
Scale{Pitch}(C₄, Dict{PitchClass, Interval}(C => Major 2nd, E => Minor 2nd, B => Minor 2nd, F => Major 2nd, D => Major 2nd, G => Major 2nd, A => Major 2nd))

julia> scale_tones = Base.Iterators.take(scale, 8) |> collect;

julia> show(scale_tones)
Pitch[C₄, D₄, E₄, F₄, G₄, A₄, B₄, C₅]
```

## Notes
Notes have a pitch and a duration, which is a rational number, e.g. `1 // 4` for a
quarter note (crotchet). Rests are specified using `rest`, e.g.
```
julia> notes = [C[5] / 4, rest / 8, D[5] / 8]
3-element Vector{Note}:
 Note(C₅, 1//4)
 Note(MusicTheory.Rest(), 1//8)
 Note(D₅, 1//8)
```

## Author

Copyright David P. Sanders, 2024
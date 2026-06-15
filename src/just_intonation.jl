"""
Five-limit just intonation ratios for the 12 semitones above the tonic, from
unison up to the major 7th. These are the small whole-number ratios that make
intervals sound acoustically pure (the fifth is exactly 3/2, the major third
exactly 5/4).
"""
const JUST_RATIOS = (
    1 // 1,    # unison
    16 // 15,  # minor 2nd
    9 // 8,    # major 2nd
    6 // 5,    # minor 3rd
    5 // 4,    # major 3rd
    4 // 3,    # perfect 4th
    45 // 32,  # tritone
    3 // 2,    # perfect 5th
    8 // 5,    # minor 6th
    5 // 3,    # major 6th
    9 // 5,    # minor 7th
    15 // 8,   # major 7th
)

"""
    JustIntonation(tonic; base_pitch = A[4], base_frequency = 440.0, octave = 4)

Five-limit just intonation built on `tonic` (a [`PitchClass`](@ref)). Each scale
degree is a pure whole-number ratio (see [`JUST_RATIOS`](@ref)) relative to the
tonic, giving beat-free intervals at the cost of being tied to one key.

The tonic is pinned to the frequency it would have in `EqualTemperament(base_pitch,
base_frequency)` (so a just C scale starts on the same C as the equal-tempered
one), placed in octave `octave`; all other pitches follow from the pure ratios.

```jldoctest
julia> ji = JustIntonation(C);

julia> frequency(ji, G[4]) / frequency(ji, C[4])   # a pure perfect fifth
1.5
```
"""
struct JustIntonation <: RatioTemperament
    tonic::PitchClass
    tonic_pitch::Pitch
    tonic_frequency::Float64
    ratios::NTuple{12,Rational{Int}}
end

function JustIntonation(tonic::PitchClass;
                        base_pitch::Pitch = A[4],
                        base_frequency::Real = 440.0,
                        octave::Int = 4)
    reference = EqualTemperament(base_pitch, Float64(base_frequency))
    tonic_pitch = tonic[octave]
    return JustIntonation(tonic, tonic_pitch, frequency(reference, tonic_pitch), JUST_RATIOS)
end

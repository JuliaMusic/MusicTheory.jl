"""
Pythagorean tuning ratios for the 12 semitones above the tonic. Every note is
reached by stacking pure perfect fifths (ratio 3/2) and folding the result back
into a single octave. The fifths are perfect, but the thirds are wide (the major
third is 81/64, noticeably sharp of the pure 5/4 of just intonation).
"""
const PYTHAGOREAN_RATIOS = (
    1 // 1,        # unison
    256 // 243,    # minor 2nd
    9 // 8,        # major 2nd
    32 // 27,      # minor 3rd
    81 // 64,      # major 3rd
    4 // 3,        # perfect 4th
    729 // 512,    # tritone
    3 // 2,        # perfect 5th
    128 // 81,     # minor 6th
    27 // 16,      # major 6th
    16 // 9,       # minor 7th
    243 // 128,    # major 7th
)

"""
    Pythagorean(tonic; base_pitch = A[4], base_frequency = 440.0, octave = 4)

Pythagorean tuning built on `tonic` (a [`PitchClass`](@ref)), in which every
pitch is a stack of pure perfect fifths (see [`PYTHAGOREAN_RATIOS`](@ref)).
Anchoring follows the same convention as [`JustIntonation`](@ref).
"""
struct Pythagorean <: RatioTemperament
    tonic::PitchClass
    tonic_pitch::Pitch
    tonic_frequency::Float64
    ratios::NTuple{12,Rational{Int}}
end

function Pythagorean(tonic::PitchClass;
                     base_pitch::Pitch = A[4],
                     base_frequency::Real = 440.0,
                     octave::Int = 4)
    reference = EqualTemperament(base_pitch, Float64(base_frequency))
    tonic_pitch = tonic[octave]
    return Pythagorean(tonic, tonic_pitch, frequency(reference, tonic_pitch), PYTHAGOREAN_RATIOS)
end

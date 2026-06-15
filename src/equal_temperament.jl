"""
    Temperament

Abstract supertype for tuning systems. A temperament assigns a frequency (in Hz)
to every [`Pitch`](@ref) via

    frequency(temperament, pitch) -> Float64
"""
abstract type Temperament end

"""
    RatioTemperament <: Temperament

Abstract supertype for temperaments defined by fixed whole-number frequency
ratios above a tonic (e.g. [`JustIntonation`](@ref), [`Pythagorean`](@ref)).

A concrete subtype must provide the fields

  * `tonic_pitch::Pitch`        — the tonic, placed in a concrete octave;
  * `tonic_frequency::Float64`  — the tonic's frequency in Hz; and
  * `ratios::NTuple{12,Rational{Int}}` — the ratio of each of the 12 semitones
    above the tonic to the tonic.

Octave handling (folding pitches above or below the tonic into the table) is
provided generically by [`frequency`](@ref).
"""
abstract type RatioTemperament <: Temperament end

"""
    EqualTemperament(base_pitch, base_frequency)

12-tone equal temperament: the octave is divided into 12 equal frequency ratios
of `2^(1/12)`, so every semitone has the same ratio. `base_pitch` is pinned to
`base_frequency` (e.g. `EqualTemperament(A[4], 440)`).
"""
struct EqualTemperament <: Temperament
    base_pitch::Pitch
    base_frequency::Float64
end


function frequency(temperament::EqualTemperament, pitch::Pitch)
    semitone_distance = semitone(pitch) - semitone(temperament.base_pitch)
    return 2.0^(semitone_distance // 12) * temperament.base_frequency
end


"""
    frequency(temperament::RatioTemperament, pitch::Pitch)

Frequency of `pitch` as a pure ratio above the tonic. The signed semitone
distance from the tonic is split into a whole number of octaves (a factor of 2
each) and a scale degree in `0:11`, which indexes the temperament's ratio table.
"""
function frequency(temperament::RatioTemperament, pitch::Pitch)
    semitone_distance = semitone(pitch) - semitone(temperament.tonic_pitch)
    octaves, step = fldmod(semitone_distance, 12)
    return temperament.tonic_frequency * 2.0^octaves * float(temperament.ratios[step + 1])
end

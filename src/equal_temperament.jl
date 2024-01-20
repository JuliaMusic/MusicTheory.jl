abstract type Temperament end

struct EqualTemperament
    base_pitch::Pitch
    base_frequency::Float64
end


function frequency(temperament::EqualTemperament, pitch::Pitch)
    semitone_distance = semitone(pitch) - semitone(temperament.base_pitch)
    return 2.0^(semitone_distance // 12) * temperament.base_frequency
end


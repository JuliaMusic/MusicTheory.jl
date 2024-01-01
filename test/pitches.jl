using MusicTheory.PitchNames

@testset "Pitches" begin
    note = C[4]

    @test PitchClass(note) == C
    @test accidental(note) == ♮
    @test octave(note) == 4
end

using MusicTheory.PitchNames

@testset "Notes" begin
    note = C[4]

    @test PitchClass(note) == C
    @test accidental(note) == ♮
    @test octave(note) == 4
end

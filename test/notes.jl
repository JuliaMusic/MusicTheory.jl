@testset "Notes with durations" begin

    using MusicTheory.PitchNames

    n = C[4] / 8
    @test n isa Note
    @test n.pitch == C[4]
    @test n.duration == 1 // 8

    n = B[5] * 3 // 8
    @test n.pitch == B[5]
    @test n.duration == 3 // 8

    n = rest / 4
    @test n isa Note
    @test n.pitch == rest
    @test n.duration == 1 // 4
end
@testset "Just intonation" begin
    ji = JustIntonation(C)
    et = EqualTemperament(A[4], 440)

    # tonic is anchored to its equal-tempered frequency:
    @test frequency(ji, C[4]) == frequency(et, C[4])

    # pure intervals are exact whole-number ratios above the tonic:
    @test frequency(ji, C[4]) / frequency(ji, C[4]) == 1 // 1
    @test frequency(ji, E[4]) / frequency(ji, C[4]) ≈ 5 // 4   # pure major third
    @test frequency(ji, G[4]) / frequency(ji, C[4]) ≈ 3 // 2   # pure perfect fifth
    @test frequency(ji, A[4]) / frequency(ji, C[4]) ≈ 5 // 3   # pure major sixth
    @test frequency(ji, C[5]) / frequency(ji, C[4]) ≈ 2 // 1   # octave

    # the just major third is flatter than the equal-tempered one:
    @test frequency(ji, E[4]) < frequency(et, E[4])

    # works for pitches below the tonic and across several octaves:
    @test frequency(ji, C[3]) ≈ frequency(ji, C[4]) / 2
    @test frequency(ji, G[3]) / frequency(ji, C[3]) ≈ 3 // 2

    @test ji isa Temperament
end

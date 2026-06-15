@testset "Equal temperament" begin
    temperament = EqualTemperament(A[4], 440)

    @test frequency(temperament, A[4]) == 440.0
    @test frequency(temperament, C[4]) == 261.6255653005986
    @test frequency(temperament, A[5]) == 880.0   # octave up doubles frequency

    # every semitone is the same ratio:
    @test frequency(temperament, C[5]) / frequency(temperament, B[4]) ≈ 2.0^(1 / 12)
end

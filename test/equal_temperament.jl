@testest "Equal temperament" begin
    temperament = EqualTemperament(A[4], 440)

    @test frequency(temperament, C[4]) == 261.6255653005986
end
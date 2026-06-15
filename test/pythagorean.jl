@testset "Pythagorean tuning" begin
    py = Pythagorean(C)
    ji = JustIntonation(C)

    # perfect fifth is pure, exactly as in just intonation:
    @test frequency(py, G[4]) / frequency(py, C[4]) ≈ 3 // 2
    @test frequency(py, G[4]) ≈ frequency(ji, G[4])

    # the Pythagorean major third (81/64) is wider than the just third (5/4):
    @test frequency(py, E[4]) / frequency(py, C[4]) ≈ 81 // 64
    @test frequency(py, E[4]) > frequency(ji, E[4])

    @test frequency(py, C[5]) / frequency(py, C[4]) ≈ 2 // 1
    @test py isa Temperament
end

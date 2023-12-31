@testset "Triads" begin
    @test is_triad(Chord(B, D, F))
    @test is_triad(B[4], D[7], F[1])

    @test !is_triad(Chord(A, B, C))
    @test !is_triad(A, B, C)
end

@testset "Triads with names" begin
    using MusicTheory.AllNoteNames

    @test is_triad(C4, E5, A8)
end

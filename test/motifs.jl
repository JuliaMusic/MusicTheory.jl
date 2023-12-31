@testset "Arpeggio" begin
    scale = Scale(C[4], major_scale)
    arpeggio_motif = Motif(scale, [2, 2, 3])

    arpeggio = collect(Base.Iterators.take(arpeggio_motif, 6))

    @test arpeggio == Pitch[C[4], E[4], G[4], C[5], E[5], G[5]]
end
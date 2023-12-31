@testset "Scales" begin

    scale = Scale(C[4], major_scale)

    scale_tones = Base.Iterators.take(scale, 8) |> collect
    @test scale_tones == Pitch[C[4], D[4], E[4], F[4], G[4], A[4], B[4], C[5]]

end
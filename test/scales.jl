@testset "Scales" begin

    scale = Scale(C[4], major_scale)

    scale_tones = Base.Iterators.take(scale, 8) |> collect
    @test scale_tones == Pitch[C[4], D[4], E[4], F[4], G[4], A[4], B[4], C[5]]

    @testset "Scale indexing" begin
        scale = Scale(D[4], major_scale)
        @test scale[0] == D[4]
        @test scale[6] == C♯[5]
        @test scale[7] == D[5]
        @test scale[-1] == C♯[4]
        @test scale[-2] == B[3]
    end


end

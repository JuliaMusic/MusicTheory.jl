@testset "Intervals" begin
    @test Interval(C[4], D[4]) == Interval(2, Major)
    @test Interval(E[4], C[4]) == Interval(3, Major)
    @test Interval(B[4], C[4]) == Interval(7, Major)

    @test Interval(B[4], C[5]) == Interval(2, Minor)

    @test Interval(B[4], B[4]) == Interval(1, Perfect)
    @test Interval(B[4], B[5]) == Interval(8, Perfect)

end

@testset "Adding intervals" begin
    @test C + Interval(2, Major) == D
    @test C + Interval(3, Major) == E
    @test C + Interval(7, Major) == B

    @test C[4] + Interval(2, Major) == D[4]
    @test B[4] + Interval(2, Major) == C♯[5]
end
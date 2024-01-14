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

    @test C[4] + Interval(8, Perfect) == C[5]
    @test C[4] + Interval(10, Minor) == E♭[5]
    @test C[4] + Interval(15, Perfect) == C[6]
end

@testset "Sum of intervals" begin
    @test Interval(3, Major) + Interval(3, Minor) == Interval(5, Perfect)
    @test Interval(3, Major) + Interval(3, Major) == Interval(5, Augmented)
    @test Interval(3, Major) + Interval(4, Diminished) == Interval(6, Minor)
    @test Interval(4, Perfect) + Interval(5, Perfect) == Interval(8, Perfect)

    major_scale = let M = Major_2nd, m = Minor_2nd
        [M, M, m, M, M, M, m]
    end

    @test sum(major_scale) == Interval(8, Perfect)
end
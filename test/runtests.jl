using SweepOperator
using Base.Test

n, p = 1000, 10
x = randn(n, p)
xtx = x'x



@testset "Sweep one by one" begin
    A = deepcopy(xtx)
    B = deepcopy(xtx)
    for j in 1:p
        sweep!(A, j)
        sweep!(A, j, true)
    end
    @test A ≈ B
end

@testset "Sweep all" begin
    A = deepcopy(xtx)
    B = deepcopy(xtx)
    sweep!(A, 1:p)
    sweep!(A, 1:p, true)
    @test A ≈ B
end

@testset "Regression" begin
    x = randn(n, p)
    y = x * collect(1.:p) + randn(n)
    xy = [x y]
    xytxy = xy'xy
    sweep!(xytxy, 1:p)
    @test xytxy[1:p, end] ≈ x\y
end

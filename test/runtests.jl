using CallByName
VERSION < v"0.7-DEV" ? using Base.Test : using Test

a = 42
x = @stub a + 1 Int
@test apply(x) == 43
@test a == 42

function f(x::CallArg{T}, y) where T<:Number
    (apply(x), apply(x), y)
end

@test f(a, 1) == (42, 42, 1)

@test f((@stub a Int), 1) == (42, 42, 1)

@test f((@stub 13 Int), 1) == (13, 13, 1)

@test f((@stub global a = a + 1 Int), 1) == (43, 44, 1)

@test_throws UndefVarError f((@stub a = a + 1 Int), 2) == (43, 44, 2)

function g()
    a = 402 + 2.0im
    f((@stub a = a + 1 Complex{Int}), 10)
end

@test g() == (403 + 2im, 404 + 2im, 10)



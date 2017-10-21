"""
    CallByName

Support the call-by-name pattern. See `CallArg`, `@stub`, and `apply`.
"""
module CallByName

export @stub, apply, CallArg

struct CallExpr{T}
    f::Function # f()::T
end

"""
    CallArg

Argument type to support call-by-name. A function defined like `f(x::CallArg{T}) = ...`
may be called like `f(@stub(a+5, Int))`.
The argument expression of the call is evaluated whenever `apply(x)` is called
within the body of `f`, but not before `f` is entered.
The function can also be called without the `@stub`; then the argument is evaluted
once before entering `f` and accessed by each call to `apply`.
"""
const CallArg{T} = Union{T, CallExpr{T}}

"""
    apply(x::CallArg{T})::T

Evaluate call argument for call-by-name.
"""
apply(ce::CallExpr{T}) where T = convert(T, ce.f())::T
apply(a) = a

"""
    @stub expression [T=Any]

Create an expression stub `CallExpr{T}(()->expression)`
which can be used as an argument of type `CallArg` to support call-by-name.
"""
macro stub(ex, T = :Any)
    if isa(ex, Expr)
        esc(:( $CallExpr{$T}(() -> $ex )))
    else
        esc(ex)
    end
end

end # module

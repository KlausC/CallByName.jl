# CallByName

[![Build Status](https://travis-ci.org/KlausC/CallByName.jl.svg?branch=master)](https://travis-ci.org/KlausC/CallByName.jl)
[![codecov.io](http://codecov.io/github/KlausC/CallByName.jl/coverage.svg?branch=master)](http://codecov.io/github/KlausC/CallByName.jl?branch=master)

Support the call-by-name feature.

### usage

```
using CallByName


function f(x::CallArg{T}) where T<:Real
    ...
    xx = apply(x)
    ...
end


julia> a = 42;
julia> f((@stub begin println("evaluating"); global a = a + 1 end, Float64));
evaluating
julia> a
43
```


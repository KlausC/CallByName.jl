# CallByName

[![Build Status](https://travis-ci.org/KlausC/CallByName.jl.svg?branch=master)](https://travis-ci.org/KlausC/CallByName.jl)
[![Coverage Status](https://coveralls.io/repos/KlausC/CallByName.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/KlausC/CallByName.jl?branch=master)
[![codecov.io](http://codecov.io/github/KlausC/CallByName.jl/coverage.svg?branch=master)](http://codecov.io/github/KlausC/CallByName.jl?branch=master)

Support the call-by-name feature.

#usage

```
using CallByName


function f(x::CallArg{T}) where T<:Real
    ...
    xx = apply(x)
    ...
end


a = 42;
f(@stub begin println("evaluating"); global a = a + 1 end, Float64);
a
43
```


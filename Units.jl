#!usr/bin/env julia
#testing version: 0.6.0

__precompile__()

module Units

import Base: show, +, -, *, /, ^, sqrt, exp, log
export Physical, show, +, -, *, /, ^, sqrt, exp, log

export meter, kilogram, second, ampere, kelvin, mole, candela
export hertz, newton, pascal, joule, watt, coulomb, volt, farad, ohm, weber, tesla, henry, lumen, lux

struct Physical{T, m, kg, s, A, K, mol, cd}
    value :: T
end

Physical(x, m, kg, s, A, K, mol, cd) = Physical{typeof(x), m, kg, s, A, K, mol, cd}(x)
Physical(x; m=0, kg=0, s=0, A=0, K=0, mol=0, cd=0) = Physical{typeof(x), m, kg, s, A, K, mol, cd}(x)

@inline character_lift(x) = Dict(
    '0' => '⁰',
    '1' => '¹',
    '2' => '²',
    '3' => '³',
    '4' => '⁴',
    '5' => '⁵',
    '6' => '⁶',
    '7' => '⁷',
    '8' => '⁸',
    '9' => '⁹',
)[x]

function show(io::IO, x::Physical{T, m, kg, s, A, K, mol, cd}) where {T, m, kg, s, A, K, mol, cd}
    print(io, "$(x.value)")
    for (u, v) in [(kg, :kg), (A, :A), (m, :m), (K, :K), (mol, :mol), (cd, :cd), (s, :s)]
        if u != 0
            print(io, "⋅", v)
            if u < 0
                print(io, '⁻')
            end
            if u != 1
                print(io, map(character_lift, collect("$(abs(u))")) |> String)
            end
        end
    end
end

include("arithmetic.jl")
include("constants.jl")

end #module

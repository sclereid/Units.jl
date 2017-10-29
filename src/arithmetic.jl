#in module Units

#addition
(+)(x::Physical{T1, m, kg, s, A, K, mol, cd}, y::Physical{T2, m, kg, s, A, K, mol, cd}) where {T1, T2, m, kg, s, A, K, mol, cd} =
    Physical(x.value + y.value, m, kg, s, A, K, mol, cd)

#negate
(-)(x::Physical{T, m, kg, s, A, K, mol, cd}) where {T, m, kg, s, A, K, mol, cd} =
    Physical(x.value - y.value, m, kg, s, A, K, mol, cd)

#substration
(-)(x::Physical{T1, m, kg, s, A, K, mol, cd}, y::Physical{T2, m, kg, s, A, K, mol, cd}) where {T1, T2, m, kg, s, A, K, mol, cd} =
    Physical(x.value - y.value, m, kg, s, A, K, mol, cd)

#multiplication with pure number
(*)(k, x::Physical{T, m, kg, s, A, K, mol, cd}) where {T, m, kg, s, A, K, mol, cd} =
    Physical{T, m, kg, s, A, K, mol, cd}(k * x.value)

(*)(x::Physical{T, m, kg, s, A, K, mol, cd}, k) where {T, m, kg, s, A, K, mol, cd} =
    Physical{T, m, kg, s, A, K, mol, cd}(x.value * k)

#general multiplication
(*)(x::Physical{T1, m1, kg1, s1, A1, K1, mol1, cd1}, y::Physical{T2, m2, kg2, s2, A2, K2, mol2, cd2}) where {T1, T2, m1, kg1, s1, A1, K1, mol1, cd1, m2, kg2, s2, A2, K2, mol2, cd2} =
    Physical(x.value * y.value, m1+m2, kg1+kg2, s1+s2, A1+A2, K1+K2, mol1+mol2, cd1+cd2)

#division with a pure number
(/)(k, x::Physical{T, m, kg, s, A, K, mol, cd}) where {T, m, kg, s, A, K, mol, cd} =
    Physical{T, -m, -kg, -s, -A, -K, -mol, -cd}(k / x.value)

(/)(x::Physical{T, m, kg, s, A, K, mol, cd}, k) where {T, m, kg, s, A, K, mol, cd} =
    Physical{T, m, kg, s, A, K, mol, cd}(x.value * k)

#general division
(/)(x::Physical{T1, m1, kg1, s1, A1, K1, mol1, cd1}, y::Physical{T2, m2, kg2, s2, A2, K2, mol2, cd2}) where {T1, T2, m1, kg1, s1, A1, K1, mol1, cd1, m2, kg2, s2, A2, K2, mol2, cd2} =
    Physical(x.value / y.value, m1-m2, kg1-kg2, s1-s2, A1-A2, K1-K2, mol1-mol2, cd1-cd2)

#power and square root
(^)(x::Physical{T, m, kg, s, A, K, mol, cd}, k) where {T, m, kg, s, A, K, mol, cd} =
    Physical(x.value ^ k, m*k, kg*k, s*k, A*k, K*k, mol*k, cd*k)

sqrt(x::Physical{T, m, kg, s, A, K, mol, cd}) where {T, m, kg, s, A, K, mol, cd} = let k = 1//2
    Physical(sqrt(x.value), m*k, kg*k, s*k, A*k, K*k, mol*k, cd*k)
end

#exponent and logrithm
#warning: all units are dropped. Probably I should come up with a better solution later
(^)(x, y::Physical) = x.value ^ k
(^)(x::Physical, y::Physical) = x ^ y.value
exp(x::Physical) = exp(x.value)

log(x::Physical) = log(x.value)
log2(x::Physical) = log2(x.value)
log10(x::Physical) = log10(x.value)
log(b, m) = log(m) - log(b)

#handling ambigious
(^)(x::Physical{T, m, kg, s, A, K, mol, cd}, k::Integer) where {T, m, kg, s, A, K, mol, cd} =
    Physical(x.value ^ k, m*k, kg*k, s*k, A*k, K*k, mol*k, cd*k)

(+)(x::Physical, y::Physical) = begin
    warn("Type mismatch while adding $x and $y")
    x.value + y.value
end
(-)(x::Physical, y::Physical) = begin
    warn("Type mismatch while adding $x and $y")
    x.value + y.value
end
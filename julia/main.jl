const lib = joinpath(@__DIR__, "..", "build", "lib", "libengine.so")

function engine_init()::Ptr{Cvoid}
    h = ccall((:engine_init, lib), Ptr{Cvoid}, ())
    h == C_NULL && error("engine_init failed")
    return h
end

function engine_step(h::Ptr{Cvoid})::Int32
    ccall((:engine_step, lib), Int32, (Ptr{Cvoid},), h)
end

function engine_value(h::Ptr{Cvoid})::Int32
    ccall((:engine_value, lib), Int32, (Ptr{Cvoid},), h)
end

h = engine_init()

for i in 1:3
    r = engine_step(h)
    r != 0 && error("engine_step failed at step $i")
end

println("Engine value = ", engine_value(h))

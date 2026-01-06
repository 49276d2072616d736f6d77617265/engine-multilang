const std = @import("std");

const EngineHandle = *anyopaque;

// === Ada symbols ===
extern fn ada_runtime_init() void;
extern fn core_state_size() usize;
extern fn core_init(h: EngineHandle) c_int;
extern fn core_step(h: EngineHandle) c_int;
extern fn core_value(h: EngineHandle, out: *c_int) c_int;

// === ABI: exported engine ===

export fn engine_init() ?EngineHandle {
    ada_runtime_init();

    const allocator = std.heap.c_allocator;
    const size = core_state_size();

    const mem = allocator.alloc(u8, size) catch return null;
    const handle = @as(EngineHandle, @ptrCast(mem.ptr));

    if (core_init(handle) != 0) {
        allocator.free(mem);
        return null;
    }

    return handle;
}

export fn engine_step(h: EngineHandle) c_int {
    return core_step(h);
}

export fn engine_value(h: EngineHandle) c_int {
    var v: c_int = 0;
    if (core_value(h, &v) != 0) return -1;
    return v;
}

export fn engine_deinit(h: EngineHandle) void {
    const allocator = std.heap.c_allocator;
    allocator.free(@as([*]u8, @ptrCast(h))[0..core_state_size()]);
}

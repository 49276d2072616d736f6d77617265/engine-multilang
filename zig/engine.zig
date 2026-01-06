const std = @import("std");

const EngineHandle = *anyopaque;

extern fn ada_runtime_init() void;

extern fn core_init() EngineHandle;
extern fn core_step(h: EngineHandle) void;
extern fn core_value(h: EngineHandle) c_int;

pub fn main() void {
    // initialize runtime before setup.
    ada_runtime_init();

    const engine = core_init();

    core_step(engine);
    core_step(engine);

    const value = core_value(engine);
    std.debug.print("Engine value = {}\n", .{value});
}

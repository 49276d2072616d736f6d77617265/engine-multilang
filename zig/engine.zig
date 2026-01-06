const std = @import("std");

const EngineHandle = *anyopaque;

extern fn ada_runtime_init() void;
extern fn core_state_size() usize;
extern fn core_init(h: EngineHandle) void;
extern fn core_step(h: EngineHandle) void;
extern fn core_value(h: EngineHandle) c_int;

pub const Engine = struct {
    handle: EngineHandle,
    allocator: std.mem.Allocator,
    size: usize,

    pub fn init(allocator: std.mem.Allocator) !Engine {
        const size = core_state_size();
        const mem = try allocator.alloc(u8, size);

        const handle: EngineHandle = @as(EngineHandle, @ptrCast(mem.ptr));
        core_init(handle);

        return .{
            .handle = handle,
            .allocator = allocator,
            .size = size,
        };
    }

    pub fn step(self: *Engine) void {
        core_step(self.handle);
    }

    pub fn value(self: *Engine) c_int {
        return core_value(self.handle);
    }

    pub fn deinit(self: *Engine) void {
        const mem: [*]u8 = @as([*]u8, @ptrCast(self.handle));
        self.allocator.free(mem[0..self.size]);
    }
};

pub fn main() !void {
    ada_runtime_init();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var engine = try Engine.init(gpa.allocator());
    defer engine.deinit();

    engine.step();
    engine.step();
    engine.step(); // throw assertion error.

    std.debug.print("Engine value = {}\n", .{engine.value()});
}

const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const getInput = @import("../input.zig").getInput;

const day = "?";

pub fn template() !void {
    const input = try getInput(day);

    print("Day {s}, part 1: {any}\n", .{ day, try partOne(input) });
    print("Day {s}, part 2: {any}\n", .{ day, try partTwo(input) });
}

fn partOne(_: []const u8) !i32 {
    const result: i32 = 0;

    return result;
}

fn partTwo(_: []const u8) !i32 {
    const result: i32 = 0;

    return result;
}

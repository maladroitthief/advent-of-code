const std = @import("std");
const print = std.debug.print;
const getInput = @import("../input.zig").getInput;

const day = "1";

pub fn historianHysteria() !void {
    const input = try getInput(day);

    partOne(input);
    partTwo(input);
}

fn partOne(input: []const u8) void {
    print("{s}\n", .{input});
}

fn partTwo(input: []const u8) void {
    print("{s}\n", .{input});
}

const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const getInput = @import("../input.zig").getInput;

const day = "4";

var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = general_purpose_allocator.allocator();

pub fn ceresSearch() !void {
    const input = try getInput(day);

    print("Day {s}, part 1: {any}\n", .{ day, try partOne(input) });
    print("Day {s}, part 2: {any}\n", .{ day, try partTwo(input) });
}

fn partOne(input: []const u8) !i32 {
    var result: i32 = 0;
    const rotated_input = try rotateInput(input);

    result += searchHorizontally(input);
    result += searchHorizontally(rotated_input);
    result += searchDiagonally(input);

    return result;
}

fn partTwo(input: []const u8) !i32 {
    var result: i32 = 0;

    result += searchXMAS(input);

    return result;
}

fn searchHorizontally(input: []const u8) i32 {
    var result: i32 = 0;
    const x: usize = 0;
    var y: usize = 0;

    const delimiter = "\n";

    const stride = std.mem.indexOf(u8, input, delimiter);

    while (y < input.len) : (y += stride.? + delimiter.len) {
        const row = input[x + y .. y + stride.?];

        result += @intCast(std.mem.count(u8, row, "XMAS"));
        result += @intCast(std.mem.count(u8, row, "SAMX"));
    }

    return result;
}

fn rotateInput(input: []const u8) ![]const u8 {
    var matrix = std.ArrayList(u8).init(gpa);
    defer matrix.deinit();

    var x: usize = 0;
    var y: usize = 0;

    const delimiter = "\n";

    const stride = std.mem.indexOf(u8, input, delimiter);

    while (x < stride.?) : (x += 1) {
        while (y < input.len) : (y += stride.? + delimiter.len) {
            try matrix.appendSlice(input[x + y .. x + y + 1]);
        }

        try matrix.append('\n');

        y = 0;
    }

    return try matrix.toOwnedSlice();
}

fn searchDiagonally(input: []const u8) i32 {
    var result: i32 = 0;

    const delimiter = "\n";

    const stride = std.mem.indexOf(u8, input, delimiter);

    var i: usize = 0;
    while (i < input.len) : (i += 1) {
        // NORTH WEST
        if (std.mem.eql(u8, input[i .. i + 1], "X")) {
            const x: i32 = -1;
            const y: i32 = -@as(i32, @intCast((stride.? + 1)));
            var j: i32 = @as(i32, @intCast(i)) + x + y;

            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                j += x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "A")) {
                    j += x + y;
                    if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                        result += 1;
                    }
                }
            }
        }
        // NORTH EAST
        if (std.mem.eql(u8, input[i .. i + 1], "X")) {
            const x: i32 = 1;
            const y: i32 = -@as(i32, @intCast(stride.? + 1));
            var j: i32 = @as(i32, @intCast(i)) + x + y;
            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                j += x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "A")) {
                    j += x + y;
                    if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                        result += 1;
                    }
                }
            }
        }
        // SOUTH WEST
        if (std.mem.eql(u8, input[i .. i + 1], "X")) {
            const x: i32 = -1;
            const y: i32 = @intCast(stride.? + 1);
            var j: i32 = @as(i32, @intCast(i)) + x + y;
            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                j += x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "A")) {
                    j += x + y;
                    if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                        result += 1;
                    }
                }
            }
        }
        // SOUTH EAST
        if (std.mem.eql(u8, input[i .. i + 1], "X")) {
            const x: i32 = 1;
            const y: i32 = @intCast(stride.? + 1);
            var j: i32 = @as(i32, @intCast(i)) + x + y;
            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                j += x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "A")) {
                    j += x + y;
                    if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                        result += 1;
                    }
                }
            }
        }
    }

    return result;
}

fn searchXMAS(input: []const u8) i32 {
    var result: i32 = 0;

    const delimiter = "\n";

    const stride = std.mem.indexOf(u8, input, delimiter);

    var i: usize = 0;
    while (i < input.len) : (i += 1) {
        var first: bool = false;
        var second: bool = false;

        if (std.mem.eql(u8, input[i .. i + 1], "A")) {
            var x: i32 = -1;
            var y: i32 = -@as(i32, @intCast((stride.? + 1)));
            var j: i32 = @as(i32, @intCast(i)) + x + y;

            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                x = 1;
                y = @as(i32, @intCast((stride.? + 1)));
                j = @as(i32, @intCast(i)) + x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                    first = true;
                }
            }
            x = -1;
            y = -@as(i32, @intCast((stride.? + 1)));
            j = @as(i32, @intCast(i)) + x + y;

            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                x = 1;
                y = @as(i32, @intCast((stride.? + 1)));
                j = @as(i32, @intCast(i)) + x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                    first = true;
                }
            }
        }

        if (std.mem.eql(u8, input[i .. i + 1], "A")) {
            var x: i32 = -1;
            var y: i32 = @as(i32, @intCast((stride.? + 1)));
            var j: i32 = @as(i32, @intCast(i)) + x + y;

            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                x = 1;
                y = -@as(i32, @intCast((stride.? + 1)));
                j = @as(i32, @intCast(i)) + x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                    second = true;
                }
            }
            x = -1;
            y = @as(i32, @intCast((stride.? + 1)));
            j = @as(i32, @intCast(i)) + x + y;

            if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "S")) {
                x = 1;
                y = -@as(i32, @intCast((stride.? + 1)));
                j = @as(i32, @intCast(i)) + x + y;
                if (j < input.len and j >= 0 and std.mem.eql(u8, input[@intCast(j)..@intCast(j + 1)], "M")) {
                    second = true;
                }
            }
        }

        if (first and second) {
            result += 1;
        }
    }

    return result;
}

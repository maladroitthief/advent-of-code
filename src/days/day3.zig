const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const getInput = @import("../input.zig").getInput;

const day = "3";

var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = general_purpose_allocator.allocator();

pub fn mullItOver() !void {
    const input = try getInput(day);

    print("Day {s}, part 1: {any}\n", .{ day, try partOne(input) });
    print("Day {s}, part 2: {any}\n", .{ day, try partTwo(input) });
}

fn partOne(input: []const u8) !i32 {
    var result: i32 = 0;

    const instructions = try parseInput(input);
    const product = try multiplyInstructions(instructions);
    result = sumArrayList(product);

    return result;
}

fn partTwo(_: []const u8) !i32 {
    const result = 0;

    return result;
}

fn parseInput(input: []const u8) !std.ArrayList([2]i32) {
    var instructions = std.ArrayList([2]i32).init(gpa);

    var start_index: ?usize = 0;
    var middle_index: ?usize = 0;
    var end_index: ?usize = 0;

    const start_pattern = "mul(";
    const middle_pattern = ",";
    const end_pattern = ")";


    var window = input;

    while (true) {
        start_index = std.mem.indexOf(
            u8,
            window,
            start_pattern,
        );
        if (start_index == null) {
            break;
        }
        const start_offset = start_index.? + start_pattern.len;

        middle_index = std.mem.indexOf(
            u8,
            window[start_offset..],
            middle_pattern,
        ).? + start_offset;
        if (middle_index == null) {
            break;
        }
        const middle_offset = middle_index.? + middle_pattern.len;

        end_index = std.mem.indexOf(
            u8,
            window[middle_offset..],
            end_pattern,
        ).? + middle_offset;
        if (end_index == null) {
            break;
        }

        const part_1 = window[start_offset..middle_index.?];
        const part_2 = window[middle_offset..end_index.?];

        const num_1 = std.fmt.parseInt(i32, part_1, 10) catch {
            start_index.? = start_offset;
            window = window[start_index.?..];
            continue;
        };
        const num_2 = std.fmt.parseInt(i32, part_2, 10) catch {
            start_index.? = start_offset;
            window = window[start_index.?..];
            continue;
        };

        try instructions.append(([2]i32{num_1, num_2}));

        start_index.? = start_offset;
        window = window[start_index.?..];
    }

    return instructions;
}

fn multiplyInstructions(instructions: std.ArrayList([2]i32)) !std.ArrayList(i32){
    var results = std.ArrayList(i32).init(gpa);

    for (instructions.items) |instruction| {
        try results.append(instruction[0] * instruction[1]);
    }

    return results;
}

fn sumArrayList(list: std.ArrayList(i32)) i32{
    var result: i32 = 0;

    for (list.items) |item| {
        result += item;
    }

    return result;
}

fn parseInputConditional(input: []const u8) !std.ArrayList([2]i32) {
    var instructions = std.ArrayList([2]i32).init(gpa);

    var start_index: ?usize = 0;
    var middle_index: ?usize = 0;
    var end_index: ?usize = 0;

    const start_pattern = "mul(";
    const middle_pattern = ",";
    const end_pattern = ")";


    var window = input;

    while (true) {
        start_index = std.mem.indexOf(
            u8,
            window,
            start_pattern,
        );
        if (start_index == null) {
            break;
        }
        const start_offset = start_index.? + start_pattern.len;

        middle_index = std.mem.indexOf(
            u8,
            window[start_offset..],
            middle_pattern,
        ).? + start_offset;
        if (middle_index == null) {
            break;
        }
        const middle_offset = middle_index.? + middle_pattern.len;

        end_index = std.mem.indexOf(
            u8,
            window[middle_offset..],
            end_pattern,
        ).? + middle_offset;
        if (end_index == null) {
            break;
        }

        const part_1 = window[start_offset..middle_index.?];
        const part_2 = window[middle_offset..end_index.?];

        const num_1 = std.fmt.parseInt(i32, part_1, 10) catch {
            start_index.? = start_offset;
            window = window[start_index.?..];
            continue;
        };
        const num_2 = std.fmt.parseInt(i32, part_2, 10) catch {
            start_index.? = start_offset;
            window = window[start_index.?..];
            continue;
        };

        try instructions.append(([2]i32{num_1, num_2}));

        start_index.? = start_offset;
        window = window[start_index.?..];
    }

    return instructions;
}

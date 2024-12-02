const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const getInput = @import("../input.zig").getInput;

const day = "1";

var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = general_purpose_allocator.allocator();

pub fn historianHysteria() !void {
    const input = try getInput(day);

    print("Day {s}, part 1: {any}\n", .{ day, try partOne(input) });
    print("Day {s}, part 2: {any}\n", .{ day, try partTwo(input) });
}

fn partOne(input: []const u8) !i32 {
    const lists = try parseInput(input);

    sortList(lists[0]);
    sortList(lists[1]);

    const delta_list = try deltaList(lists[0], lists[1]);
    return sumList(delta_list);
}

fn partTwo(input: []const u8) !i32 {
    const lists = try parseInput(input);

    sortList(lists[0]);
    sortList(lists[1]);

    const similarity_score = try similarityScore(lists[0], lists[1]);
    return sumList(similarity_score);
}

fn parseInput(input: []const u8) ![2]std.ArrayList(i32) {
    var results = [2]std.ArrayList(i32){
        std.ArrayList(i32).init(gpa),
        std.ArrayList(i32).init(gpa),
    };

    var lines = std.mem.split(u8, input, "\n");
    while (lines.next()) |line| {
        if (line.len <= 0) {
            break;
        }

        var nums = std.mem.split(u8, line, "   ");

        const first = try std.fmt.parseInt(i32, nums.next().?, 10);
        const second = try std.fmt.parseInt(i32, nums.next().?, 10);
        try results[0].append(first);
        try results[1].append(second);
    }

    return results;
}

fn sortList(list: std.ArrayList(i32)) void {
    std.mem.sort(i32, list.items, {}, std.sort.asc(i32));
}

fn deltaList(left_list: std.ArrayList(i32), right_list: std.ArrayList(i32)) !std.ArrayList(i32) {
    var results = std.ArrayList(i32).init(gpa);

    for (left_list.items, right_list.items) |x, y| {
        if (x < y) {
            try results.append(y - x);
        } else {
            try results.append(x - y);
        }
    }

    return results;
}

fn sumList(list: std.ArrayList(i32)) i32 {
    var result: i32 = 0;

    for (list.items) |x| {
        result += x;
    }

    return result;
}

fn similarityScore(left_list: std.ArrayList(i32), right_list: std.ArrayList(i32)) !std.ArrayList(i32) {
    var results = std.ArrayList(i32).init(gpa);

    var i: usize = 0;
    while (i < left_list.items.len) : (i += 1) {
        const x: []i32 = left_list.items[i .. i + 1];
        assert(x.len == 1);

        const score: i32 = @intCast(std.mem.count(i32, right_list.items, x));

        try results.append(x[0] * score);
    }

    return results;
}

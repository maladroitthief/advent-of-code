const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const getInput = @import("../input.zig").getInput;

const day = "5";

var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = general_purpose_allocator.allocator();

pub fn printQueue() !void {
    const input = try getInput(day);

    print("Day {s}, part 1: {any}\n", .{ day, try partOne(input) });
    print("Day {s}, part 2: {any}\n", .{ day, try partTwo(input) });
}

fn partOne(input: []const u8) !u32 {
    var result: u32 = 0;

    var rules = try parseRules(input);
    defer rules.deinit();

    var queues = try parseQueue(input);
    defer queues.deinit();

    for (queues.items) |queue| {
        if (try evaluateQueue(rules, queue)) {
            const middle = try getMiddlePage(queue);
            result += @intCast(middle);
        }
    }

    return result;
}

fn partTwo(input: []const u8) !u32 {
    var result: u32 = 0;

    var rules = try parseRules(input);
    defer rules.deinit();

    var queues = try parseQueue(input);
    defer queues.deinit();

    for (queues.items) |queue| {
        if (try evaluateQueue(rules, queue)) {} else {
            const sorted_queue = sortQueue(rules, queue);

            assert(try evaluateQueue(rules, sorted_queue));

            const middle = try getMiddlePage(sorted_queue);
            result += @intCast(middle);
        }
    }

    return result;
}

fn parseRules(input: []const u8) !std.AutoHashMap(i32, []i32) {
    var rules = std.AutoHashMap(i32, []i32).init(gpa);
    var lines = std.mem.split(u8, input, "\n");

    while (lines.next()) |line| {
        var values = std.ArrayList(i32).init(gpa);
        defer values.deinit();

        if (line.len <= 0) {
            break;
        }

        if (std.mem.eql(u8, line, "\n")) {
            break;
        }

        var data = std.mem.split(u8, line, "|");
        const part_one = data.next();
        const part_two = data.next();

        const key = try std.fmt.parseInt(i32, part_one.?, 10);
        const value = try std.fmt.parseInt(i32, part_two.?, 10);

        if (rules.contains(key)) {
            const existing_value = rules.get(key).?;
            try values.appendSlice(existing_value);
        }

        try values.append(value);
        try rules.put(key, try values.toOwnedSlice());
    }

    return rules;
}

fn parseQueue(input: []const u8) !std.ArrayList([]i32) {
    var queues = std.ArrayList([]i32).init(gpa);
    var lines = std.mem.split(u8, input, "\n");

    while (lines.next()) |line| {
        if (line.len <= 0) {
            break;
        }
    }

    while (lines.next()) |line| {
        var queue = std.ArrayList(i32).init(gpa);
        defer queue.deinit();

        if (line.len <= 0) {
            break;
        }

        var nums = std.mem.split(u8, line, ",");
        while (nums.next()) |num| {
            if (num.len <= 0) {
                break;
            }

            try queue.append(try std.fmt.parseInt(i32, num, 10));
        }

        try queues.append(try queue.toOwnedSlice());
    }

    return queues;
}

fn getMiddlePage(input: []i32) !i32 {
    const middle_index: usize = @intCast(try std.math.divCeil(
        i32,
        @intCast(input.len),
        2,
    ));
    return input[middle_index - 1];
}

fn evaluateQueue(rule_book: std.AutoHashMap(i32, []i32), queue: []i32) !bool {
    var history = std.AutoHashMap(i32, bool).init(gpa);
    defer history.deinit();

    for (queue) |value| {
        const rules = rule_book.get(value);
        for (rules.?) |rule| {
            if (history.contains(rule)) {
                return false;
            }
        }

        try history.put(value, true);
    }

    return true;
}

fn sortQueue(rule_book: std.AutoHashMap(i32, []i32), queue: []i32) []i32 {
    var i: usize = 0;
    var j: usize = 0;
    while (i < queue.len) : (i += 1) {
        while (j < i) {
            const rules = rule_book.get(queue[i]);
            const bad_index = std.mem.indexOf(i32, rules.?, queue[j .. j + 1]);
            if (bad_index == null) {
                j += 1;
                continue;
            }

            const temp = queue[j];
            queue[j] = queue[i];
            queue[i] = temp;
            i = j;
            j = 0;
        }
    }

    return queue;
}

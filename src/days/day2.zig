const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const getInput = @import("../input.zig").getInput;

const day = "2";

var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = general_purpose_allocator.allocator();

pub fn redNosedReports() !void {
    const input = try getInput(day);

    print("Day {s}, part 1: {any}\n", .{ day, try partOne(input) });
    print("Day {s}, part 2: {any}\n", .{ day, try partTwo(input) });
}

fn partOne(input: []const u8) !i32 {
    var result: i32 = 0;

    const reports = try parseInput(input);
    for (reports.items) |report| {
        result += checkAscending(report, 0);
        result += checkDescending(report, 0);
    }

    return result;
}

fn partTwo(input: []const u8) !i32 {
    var result: i32 = 0;

    const reports = try parseInput(input);
    for (reports.items) |report| {
        var status: i32 = checkAscending(report, 1);
        status += checkDescending(report, 1);

        if (status == 0) {
            std.mem.reverse(i32, report);
            status += checkAscending(report, 1);
            status += checkDescending(report, 1);
        }

        result += status;
    }

    return result;
}

fn parseInput(input: []const u8) !std.ArrayList([]i32) {
    var reports = std.ArrayList([]i32).init(gpa);
    var lines = std.mem.split(u8, input, "\n");

    while (lines.next()) |line| {
        if (line.len <= 0) {
            break;
        }

        var levels = std.mem.split(u8, line, " ");
        var report = std.ArrayList(i32).init(gpa);
        while (levels.next()) |level| {
            if (level.len <= 0) {
                break;
            }

            try report.append(try std.fmt.parseInt(i32, level, 10));
        }

        try reports.append(report.items);
    }

    return reports;
}

fn checkAscending(levels: []i32, tolerance_max: i32) i32 {
    var tolerance: i32 = 0;
    var current = levels[0];

    var i: usize = 1;
    while (i < levels.len) : (i += 1) {
        const next = levels[i];
        const is_bad: bool = current > next or
            next - current > 3 or
            next - current <= 0;

        if (is_bad and tolerance < tolerance_max) {
            tolerance += 1;
            if (i == 1) {
                current = next;
            }

            continue;
        }

        if (is_bad) {
            return 0;
        }

        current = next;
    }

    return 1;
}

fn checkDescending(levels: []i32, tolerance_max: i32) i32 {
    var tolerance: i32 = 0;
    var current = levels[0];

    var i: usize = 1;
    while (i < levels.len) : (i += 1) {
        const next = levels[i];
        const is_bad: bool = current < next or
            current - next > 3 or
            current - next <= 0;

        if (is_bad and tolerance < tolerance_max) {
            tolerance += 1;
            if (i == 1) {
                current = next;
            }

            continue;
        }

        if (is_bad) {
            return 0;
        }

        current = next;
    }

    return 1;
}

const std = @import("std");
const http = std.http;

const year = "2024";
var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = general_purpose_allocator.allocator();

fn Kilobytes(comptime value: comptime_int) comptime_int {
    return value * 1024;
}

fn Megabytes(comptime value: comptime_int) comptime_int {
    return Kilobytes(value) * 1024;
}

pub fn getInput(day: []const u8) ![]const u8 {
    const url = try std.fmt.allocPrint(
        gpa,
        "https://adventofcode.com/{s}/day/{s}/input",
        .{ year, day },
    );
    const uri = try std.Uri.parse(url);

    var client = http.Client{ .allocator = gpa };
    defer client.deinit();

    var token: []u8 = undefined;
    const file = try std.fs.cwd().openFile(
        "token",
        .{ .mode = .read_only },
    );
    defer file.close();

    const filesize = (try file.stat()).size;
    token = try gpa.alloc(u8, filesize);

    _ = try file.readAll(token);

    const session = std.http.Header{
        .name = "cookie",
        .value = @ptrCast(token),
    };

    const headers = [_]http.Header{session};

    var header_buffer: [4096]u8 = undefined;

    var request = try client.open(.GET, uri, .{ .server_header_buffer = &header_buffer });
    defer request.deinit();

    request.extra_headers = &headers;

    try request.send();
    try request.finish();

    try request.wait();
    return try request.reader().readAllAlloc(gpa, Megabytes(10));
}

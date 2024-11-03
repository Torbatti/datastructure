const std = @import("std");
const expect = std.testing.expect;

const SinglyStruct = struct {
    const Node = struct {
        value: u8,
        next: *Node,
    };

    first: ?*Node = null,
    last: ?*Node = null,
    len: usize = 0,
};

test "SinglyStruct" {
    const empty_singly_list = SinglyStruct{};
    try expect(empty_singly_list.len == 0);
}


pub fn SinglyType(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node,
            next: ?*Node,
            value: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,
    };
}

test "SinglyType" {
    const singly_i32 = SinglyType(i32);
    const empty_singly_i32_list = singly_i32{};
    try expect(empty_singly_i32_list.len == 0);

}
const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;

const SinglyStruct = struct {
    const Node = struct {
        value: u8,
        next: ?*Node = null,
    };

    first: ?*Node = null,
    last: ?*Node = null,
    len: usize = 0,

    pub fn append(singly_list: *SinglyStruct,node: *Node) void {
        if (singly_list.*.last != null) {
            singly_list.*.last.?.next = node;
        }

        if (singly_list.*.last == null) {
            singly_list.*.first = node;
        }
        singly_list.*.last = node;
    }
};

test "SinglyStruct" {
    const empty_list = SinglyStruct{};
    try expect(empty_list.len == 0);

    var singly_list = SinglyStruct{};
    var node_1 = SinglyStruct.Node{.value = 0,};
    SinglyStruct.append(&singly_list,&node_1);
    var node_2 = SinglyStruct.Node{.value = 127,};
    SinglyStruct.append(&singly_list,&node_2);
    var node_3 = SinglyStruct.Node{.value = 255,};
    SinglyStruct.append(&singly_list,&node_3);
    
    try expect(singly_list.first.?.value ==  0);
    try expect(singly_list.first.?.next.?.value ==  127);
    try expect(singly_list.last.?.value ==  255);
}


pub fn SinglyType(comptime T: type) type {
    return struct {
        pub const Node = struct {
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
    const empty_i32_list = singly_i32{};
    try expect(empty_i32_list.len == 0);

}
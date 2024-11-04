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
        singly_list.len += 1;
    }

    pub fn detach_last(singly_list: *SinglyStruct) void {

        var temp_node_pointer: *Node = undefined;
        temp_node_pointer = singly_list.first orelse return; // list is empty

        while (true) {
            // there is only one node in the list
            _ = temp_node_pointer.next orelse {
                assert(singly_list.*.first == singly_list.*.last);
                
                singly_list.*.first = null;
                singly_list.*.last = null;
                return;
            };

            // more than one node in the list
            if (temp_node_pointer.next.?.next != null) {
                temp_node_pointer = temp_node_pointer.next orelse unreachable; // unreachable should never happen
            }else {
                // youve reached the last two nodes
                // make last pointer point at the temp pointer
                // detach the last node from next pointer by making it null
                singly_list.*.last = temp_node_pointer;
                temp_node_pointer.*.next = null;
                return;
            }
        }
    }
};

test "SinglyStruct" {
    const empty_list = SinglyStruct{};
    try expect(empty_list.len == 0);

    var singly_list = SinglyStruct{};
    
    var node_1 = SinglyStruct.Node{.value = 0,};
    SinglyStruct.append(&singly_list,&node_1);
    try expect(singly_list.len ==  1);

    var node_2 = SinglyStruct.Node{.value = 127,};
    SinglyStruct.append(&singly_list,&node_2);
    try expect(singly_list.len ==  2);

    var node_3 = SinglyStruct.Node{.value = 255,};
    SinglyStruct.append(&singly_list,&node_3);
    try expect(singly_list.len ==  3);


    try expect(singly_list.first.?.value ==  0);
    try expect(singly_list.first.?.next.?.value ==  127);
    try expect(singly_list.last.?.value ==  255);

    SinglyStruct.detach_last(&singly_list);
    try expect(singly_list.last.?.value ==  127);

    SinglyStruct.detach_last(&singly_list);
    try expect(singly_list.last.?.value ==  0);

    SinglyStruct.detach_last(&singly_list);
    try expect(singly_list.last == null);


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
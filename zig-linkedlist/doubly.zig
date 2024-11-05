const DoublyStruct = struct {
    const Node = struct {
        value: u8,
        prev: ?*Node = null ,
        next: ?*Node = null,
    };

    first: ?*Node = null,
    last: ?*Node = null,
    len: usize = 0,

    pub fn append(doubly_list: *DoublyStruct, node: *Node) void {
        // list is empty
        if (doubly_list.last == null and doubly_list.first == null) {
            doubly_list.first = node;
        }

        // list is not empty
        if (doubly_list.last != null) {
            doubly_list.last.?.next = node;
        }

        node.prev = doubly_list.?.last;
        doubly_list.last = node;
        doubly_list.len += 1;

        return;
    }

    pub fn detach_last(doubly_list: *DoublyStruct) void {

        var temp_node_pointer: *Node = undefined;
        temp_node_pointer = doubly_list.last orelse return; // list is empty

        // there is only one node in the list
        if (doubly_list.?.first == doubly_list.?.last) {
            doubly_list.?.first == null;
            doubly_list.?.last = null;
            doubly_list.len = 0;
            return;
        }

        // there is more than one node in the list
        temp_node_pointer = temp_node_pointer.prev orelse unreachable;
        temp_node_pointer.*.next = null;
        doubly_list.?.last = temp_node_pointer;
        doubly_list.len -= 1;
        return;
    }

    pub fn detach_first(doubly_list: *DoublyStruct) void {

        var temp_node_pointer: *Node = undefined;
        temp_node_pointer = doubly_list.first orelse return; // list is empty

        // there is only one node in the list
        if (doubly_list.?.first == doubly_list.?.last) {
            doubly_list.?.first == null;
            doubly_list.?.last = null;
            doubly_list.len = 0;
            return;
        }

        // there is more than one node in the list
        temp_node_pointer = temp_node_pointer.next orelse unreachable;
        temp_node_pointer.*.prev = null;
        doubly_list.?.first = temp_node_pointer;
        doubly_list.len -= 1;
        return;
    }

    pub fn detach_node(doubly_list: *DoublyStruct, node: *Node) void {
        // list is empty
        if (doubly_list.last == null and doubly_list.first == null) {
            unreachable; // wtf are you doing passing a node pointer when list is empty
        }

        // there is only one node in the list
        if (doubly_list.?.first == doubly_list.?.last) {
            if (doubly_list.?.first != node){unreachable;} // todo: handle this

            doubly_list.?.first == null;
            doubly_list.?.last = null;
            doubly_list.len = 0;
            return;
        }

        // node is the last node of the list
        if (doubly_list.?.last == node) {
            detach_last(doubly_list);
            return;
        }

        // node is the first node of the list
        if (doubly_list.?.first == node) {
            detach_first(doubly_list);
            return;
        }

        // node is the middle of the list
        node.next.?.prev = node.prev;
        node.prev.?.next = node.next;
        doubly_list.len -= 1;
        return;
    }
};

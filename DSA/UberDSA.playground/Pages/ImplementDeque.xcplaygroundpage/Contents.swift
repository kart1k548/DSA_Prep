//struct Deque<T> {
//    private var left: [T] = []
//
//    private var right: [T] = []
//
//    var isEmpty: Bool {
//        left.isEmpty && right.isEmpty
//    }
//
//    mutating func pushFront(_ x: T) {
//        left.append(x)
//    }
//
//    mutating func pushBack(_ x: T) {
//        right.append(x)
//    }
//
//    mutating func popFront() -> T? {
//        if left.isEmpty {
//            left = right.reversed()
//            right.removeAll()
//        }
//        
//        return left.popLast()
//    }
//}
//
//var q = Deque<Int>()
//q.pushBack(4)
//q.pushBack(5)
//q.pushBack(6)
//q.pushFront(1)
//q.pushFront(0)
//
//while !q.isEmpty {
//    print(q.popFront()!)
//}


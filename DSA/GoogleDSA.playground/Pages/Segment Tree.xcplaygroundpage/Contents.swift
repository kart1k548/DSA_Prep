//class SegTree {
//    var nums: [Int]
//    var tree: [Int]
//    
//    init(nums: [Int] = [-2, 0, 3, -5, 2, -1]) {
//        self.nums = nums
//        self.tree = Array(repeating: 0, count: 4 * nums.count)
//        build(0, nums.count - 1, 0)
//    }
//
//    private func build(_ lo: Int, _ hi: Int, _ node: Int) -> Int {
//        if lo == hi {
//            tree[node] = nums[lo]
//            return tree[node]
//        }
//        
//        let mid = lo + (hi - lo) / 2
//        
//        let left = build(lo, mid, 2 * node + 1)
//        let right = build(mid + 1, hi, 2 * node + 2)
//        
//        tree[node] = left + right
//        return tree[node]
//    }
//    
//    func addNum(_ val: Int) {
//        nums.append(val)
//        update(0, 0, nums.count - 1, nums.count - 1, val)
//    }
//    
//    func update(_ node: Int, _ lo: Int, _ hi: Int, _ indx: Int, _ val: Int) {
//        if lo == hi {
//            tree[node] = val
//            return
//        }
//        let mid = (lo + hi) / 2
//        if indx <= mid {
//            update(2 * node + 1, lo, mid, indx, val)
//        } else {
//            update(2 * node + 2, mid + 1, hi, indx, val)
//        }
//        tree[node] = tree[2 * node + 1] + tree[2 * node + 2]
//    }
//}
//
//let tree = SegTree()
//print(tree.tree)
//tree.addNum(7)
//print(tree.tree)

class Waitlist {
    private var sizeArr: [Int] = []
    var segTree: [Int] = []
    private var n = 0
    
    init(capacity: Int) {
        sizeArr = []
        segTree = Array(repeating: Int.max, count: 4 * capacity)
    }
    
    // MARK: - Add group
    func addGroup(_ size: Int) {
        sizeArr.append(size)
        update(0, 0, sizeArr.count - 1, sizeArr.count - 1, size)
    }
    
    // MARK: - Remove group
    func removeGroup(at index: Int) {
        guard index < sizeArr.count else { return }
        update(0, 0, sizeArr.count - 1, index, Int.max)
    }
    
    // MARK: - Find group
    func findGroup(_ tableSize: Int) -> Int? {
        return query(0, 0, sizeArr.count - 1, tableSize)
    }
    
    // MARK: - Segment Tree Update
    private func update(_ node: Int, _ start: Int, _ end: Int, _ idx: Int, _ val: Int) {
        if start == end {
            segTree[node] = val
            return
        }
        
        let mid = (start + end) / 2
        if idx <= mid {
            update(2 * node + 1, start, mid, idx, val)
        } else {
            update(2 * node + 2, mid + 1, end, idx, val)
        }
        
        segTree[node] = min(segTree[2 * node + 1], segTree[2 * node + 2])
    }
    
    // MARK: - Query
    private func query(_ node: Int, _ start: Int, _ end: Int, _ tableSize: Int) -> Int? {
        if segTree[node] > tableSize {
            return nil
        }
        
        if start == end {
            return start
        }
        
        let mid = (start + end) / 2
        
        if let left = query(2 * node + 1, start, mid, tableSize) {
            return left
        }
        
        return query(2 * node + 2, mid + 1, end, tableSize)
    }
}

var waitlist = Waitlist(capacity: 10)
waitlist.addGroup(4)
waitlist.addGroup(2)
waitlist.addGroup(3)
waitlist.addGroup(6)
waitlist.addGroup(5)
waitlist.removeGroup(at: 3)
print(waitlist.findGroup(3) ?? 0)
print(waitlist.segTree)


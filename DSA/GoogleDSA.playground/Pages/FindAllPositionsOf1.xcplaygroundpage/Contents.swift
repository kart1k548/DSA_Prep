// Ques: https://leetcode.com/discuss/post/4834179/google-l4-onsite-by-anonymous_user-eqlw/


func query(_ A: [Int], _ L: Int, _ R: Int) -> Bool {
    for i in L...R {
        if A[i] == 1 {
            return true
        }
    }
    
    return false
}

// MARK: RECURSIVE
//func getAllPositions(_ arr: [Int]) -> [Int] {
//    var l = 0
//    var r = arr.count - 1
//    var ans = [Int]()
//    
//    func binarySearch(_ l: Int, _ r: Int) {
//        if l == r {
//            ans.append(l)
//            return
//        }
//        
//        let mid = (l + r) / 2
//        
//        if query(arr, l, mid) {
//            binarySearch(l, mid)
//        }
//        if query(arr, mid + 1, r) {
//            binarySearch(mid + 1, r)
//        }
//    }
//    
//    binarySearch(l, r)
//    
//    return ans
//}

// MARK: ITERATIVE QUEUE
//func getAllPositions(_ arr: [Int]) -> [Int] {
//    var left = 0
//    var right = arr.count - 1
//    var ans = [Int]()
//    
//    var q = [(l: Int, r: Int)]()
//    var idx = 0
//    q.append((l: left, r: right))
//    
//    while idx < q.count {
//        var curr = q[idx]
//        idx += 1
//        
//        if !query(arr, curr.l, curr.r) {
//            continue
//        }
//        
//        if curr.l == curr.r {
//            ans.append(curr.l)
//            continue
//        }
//        
//        let mid = (curr.l + curr.r) / 2
//        
//        if query(arr, curr.l, mid) {
//            q.append((l: curr.l, r: mid))
//        }
//        
//        if query(arr, mid + 1, curr.r) {
//            q.append((l: mid + 1, r: curr.r))
//        }
//    }
//    
//    return ans
//}


// MARK: SPACE OPTIMIZED
func getAllPositions(_ arr: [Int]) -> [Int] {
    let n = arr.count
    var ans = [Int]()
    var start = 0
    
    while start < n {
        // check if any 1 exists in remaining range
        if !query(arr, start, n - 1) {
            break
        }
        var left = start
        var right = n - 1
        
        // binary search for first 1
        while left < right {
            let mid = (left + right) / 2
            
            if query(arr, left, mid) {
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        // found a 1
        ans.append(left)
        start = left + 1
    }
    
    return ans
}

let arr = [0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1]
print(getAllPositions(arr))



// An integer interval [A, B] is a collection of all successive integers between A and B, including A and B.
// You are given a 2D array A of dimensions N x 2, with each row representing an range
// Find the smallest size of a set S such that the intersection of S with each range be of at least size 2
// For eg. Input: a = [[1, 3], [1, 4], [2, 5], [3, 5]]; Output will be 3
// And set S can be [2, 3, 5] -> S ∩ [1, 3] is 2 i.e. {2, 3} (Same for [1, 4]); S ∩ [2, 5] is 2 i.e. {2, 5}; S ∩ [3, 5] is 2 i.e. {3, 5}

func getSmallestSet(_ ranges: [[Int]]) -> Int {
    var res = [Int]()
    
    var sortedRangesByEnds = ranges.sorted(by: {
        if $0[1] == $1[1] { return $0[0] > $1[0] }
        
        return $0[1] < $1[1]
    })
    
    for range in sortedRangesByEnds {
        let rangeStart = range[0]
        let rangeEnd = range[1]
        
        if res.isEmpty {
            res.append(rangeEnd - 1)
            res.append(rangeEnd)
        } else {
            let secondLargestNum = res[res.count - 2]
            let largestNum = res[res.count - 1]
            
            if secondLargestNum >= rangeStart {
                continue
            } else {
                if rangeStart == largestNum {
                    res.append(rangeEnd)
                } else if rangeStart > largestNum {
                    res.append(rangeEnd - 1)
                    res.append(rangeEnd)
                }
            }
        }
    }
    
    return res.count
}

print(getSmallestSet([[1, 3], [1, 4], [2, 5], [3, 5]]))

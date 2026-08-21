// Ques: https://leetcode.com/discuss/post/5804713/google-l4-bangalore-rejected-by-anonymou-5gal/


// MARK: NOT OPTIMAL
//func longestSequence(_ nums: [Int]) -> Int {
//    let n = nums.count
//    
//    var map = [Int: [Int]]()
//    for i in 0 ..< n {
//        map[nums[i], default: []].append(i)
//    }
//    
//    var maxLen = 1
//
//    for i in 0 ..< n {
//        var idx = i
//        var curr = nums[i]
//        var next = curr + 1
//        
//        while let arr = map[next], let indx = arr.first(where: { $0 > idx }) {
//            idx = indx
//            next += 1
//        }
//        
//        let len = next - curr
//        maxLen = max(maxLen, len)
//    }
//    
//    return maxLen
//}


// MARK: OPTIMAL USING DP
func longestSequence(_ nums: [Int]) -> Int {
    var dp = [Int: Int]()
    var maxLen = 0
    
    for num in nums {
        let len = (dp[num - 1] ?? 0) + 1
        dp[num] = len
        maxLen = max(maxLen, len)
    }
    
    return maxLen
}

func longestSequenceUptoKDiff(_ nums: [Int], _ k: Int) -> Int {
    var dp = [Int: Int]()
    var maxLen = 0
    
    for num in nums {
        var biggestLen = 0
        for prev in (num - k) ... (num - 1) {
            biggestLen = max(biggestLen, (dp[prev] ?? 0))
        }
        
        dp[num] = biggestLen + 1
        maxLen = max(maxLen, dp[num]!)
    }
    
    return maxLen
}

let nums = [100,4,200,1,3,2]
//let nums = [100, 99, 100, 101]
print(longestSequence(nums))
print(longestSequenceUptoKDiff(nums, 2))
      


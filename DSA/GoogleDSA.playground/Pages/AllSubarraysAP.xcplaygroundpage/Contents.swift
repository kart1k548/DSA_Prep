// Ques: https://leetcode.com/discuss/post/5584385/google-interview-experience-l4-software-7n277/

func getAllSubarraysCount(_ nums: [Int]) -> Int {
    var res = 0
    
    var l = 0
    var r = 1
    
    while r < nums.count {
        if nums[r] != nums[r - 1] + 1 {
            let diff = r - l
            res += (diff * (diff - 1)) / 2
            l = r
        }
        r += 1
    }
    
    let diff = r - l
    res += (diff * (diff - 1)) / 2
    
    l = 0
    r = 1
    
    while r < nums.count {
        if nums[r] != nums[r - 1] - 1 {
            let diff = r - l
            res += (diff * (diff - 1)) / 2
            l = r
        }
        r += 1
    }
    
    let len = r - l
    res += (len * (len - 1)) / 2
    
    return res
}

//let nums = [1,2,1,2,1]
let nums = [1,2,3,10,9,8,7,20]
print(getAllSubarraysCount(nums))

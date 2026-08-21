

func getAllSubsets(_ arr: [Int]) -> [[Int]] {
    let total = 1 << arr.count
    var res = [[Int]]()
    
    for i in 0 ..< total {
        var n = i
        var ans = [Int]()
        var bIndex = 0
        
        while n != 0 {
            if n & 1 == 1 {
                ans.append(arr[bIndex])
            }
            bIndex += 1
            n = n >> 1
        }
        
        res.append(ans)
    }
    
    return res
}

print(getAllSubsets([1, 2, 3]))

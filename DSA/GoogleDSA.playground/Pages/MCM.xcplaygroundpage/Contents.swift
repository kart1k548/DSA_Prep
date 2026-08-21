func compute(_ arr: [Int]) -> Int {
  var res = 0
  let n = arr.count
  var dp = Array(repeating: Array(repeating: -1, count: n), count: n)
  
  func recur(_ i: Int, _ j: Int) -> Int {
    if i >= j {
      return 0
    }
    
    if dp[i][j] != -1 {
      return dp[i][j]
    }
    
    var mini = Int.max
    for k in i ..< j {
      let ans = arr[i - 1] * arr[k] * arr[j] + recur(i, k) + recur(k + 1, j)
      
      mini = min(mini, ans)
    }
    
    dp[i][j] = mini
    
    return mini
  }
  
  res = recur(1, arr.count - 1)
  
  return res
}

var arr = [2,1,3,4]

print(compute(arr))

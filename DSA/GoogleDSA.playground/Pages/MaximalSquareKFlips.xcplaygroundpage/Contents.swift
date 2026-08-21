// Ques: https://leetcode.com/discuss/post/5804713/google-l4-bangalore-rejected-by-anonymou-5gal/


func maximalSquareKFlips(_ matrix: [[Character]], _ k: Int) -> Int {
    let m = matrix.count
    let n = matrix[0].count
    var maxLen = 0
    
    for r in 0 ..< m {
        for c in 0 ..< n {
            var len = 0
            var zeroes = 0
            
            while r + len < m && c + len < n {
                // add bottom row
                for j in c ... (c + len) {
                    if matrix[r + len][j] == "0" {
                        zeroes += 1
                    }
                }
                
                // add last column, exculding the corner (i.e. matrix[r + len][c + len]), as it is covered by prev loop
                for i in r ..< (r + len) {
                    if matrix[i][c + len] == "0" {
                        zeroes += 1
                    }
                }
                
                if zeroes > k { break }
                
                len += 1
                
                maxLen = max(len, maxLen)
            }
        }
    }
    
    return maxLen * maxLen
}

let matrix: [[Character]] = [
    ["1","0","1","0","0"],
    ["1","0","1","1","1"],
    ["1","1","1","1","1"],
    ["1","0","0","1","0"]
]
print(maximalSquareKFlips(matrix, 2))

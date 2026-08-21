// Given a size N array, for every K sized rolling window in the array, find the minimum absolute difference between any two elements in the K sized window.
// Input: [5, 3, 1, 4, 2]; k = 3
// Output: [2, 1, 1]
// Optimal soln will include the use of Balanced BST for the elements in window and their respective diffs which brings down the complexity to O(NlogK)
//Without sortedDiffs — O(NK)
//Each slide you:
//
//Insert/Delete from sortedWindow (balanced BST) → O(log K)
//Iterate through all K elements of sortedWindow to compute min diff → O(K)
//
//The O(K) scan dominates, giving O(NK) overall.
//
//With sortedDiffs — O(N log K)
//Each slide you:
//
//Insert/Delete from sortedWindow → O(log K)
//Surgically update sortedDiffs (at most 2 removals, 2 insertions) → O(log K)
//Query min of sortedDiffs → O(log K)
//
//No full scan ever happens. Every operation is O(log K), giving O(N log K) overall.


func getMinDiffList(_ nums: [Int], _ k: Int) -> [Int] {
    func getMinDiff(_ arr: [Int]) -> Int {
        if arr.count <= 1 { return -1 }
        let sorted = arr.sorted()
        let n = arr.count
        
        var l = 0
        var r = 1
        var minDiff = Int.max
        
        while r < n {
            minDiff = min(minDiff, sorted[r] - sorted[l])
            l += 1
            r += 1
        }
        
        return minDiff
    }
    
    let n = nums.count
    var l = 0
    var r = k - 1
    var res = [Int]()
    
    while r < n {
        res.append(getMinDiff(Array(nums[l ... r])))
        l += 1
        r += 1
    }
    
    return res
}

print(getMinDiffList([9, 4, 7, 2, 6, 3, 8, 1, 5], 4))


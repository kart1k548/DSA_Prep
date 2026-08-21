// Given a sorted array with positive and negative values, sort them based on the square of its values. Also, print the squared values array.
// Expected O(N) working code and interviewer made me run the code with sample tests and compare output
// Sample: [-7, -2, -1, -1, 1, 2, 2, 2, 3, 5] => [-1, -1, 1, -2, 2, 2, 2, 3, 5, -7]
// Follow Up: Now, given the same array, how would you modify your code to find the kth smallest square element in the array. O(LogN)

//func sortSquares(_ arr: [Int]) -> [Int] {
//    let n = arr.count
//    var l = 0
//    var r = n - 1
//    var idx = n - 1
//    var res = Array(repeating: -1, count: n)
//    
//    while l < r {
//        if abs(arr[l]) > abs(arr[r]) {
//            res[idx] = arr[l]
//            l += 1
//        } else if abs(arr[l]) < abs(arr[r]) {
//            res[idx] = arr[r]
//            r -= 1
//        } else {
//            if arr[l] < arr[r] {
//                res[idx] = arr[r]
//                r -= 1
//            } else {
//                res[idx] = arr[l]
//                l += 1
//            }
//        }
//        
//        idx -= 1
//    }
//    
//    res[0] = arr[l]
//    
//    return res
//}

func getElement(_ arr: [Int], _ k: Int) -> Int {
    let n = arr.count
    let posIndx = getFirstPosIndx(arr)
    let n1 = posIndx
    let n2 = n - posIndx
    
    return getKthElement
}

func getKthElement(_ smaller: [Int], _ larger: [Int], _ k: Int, _ isSmallerNeg: Bool, _ firstPosIndex: Int) -> Int {
    
}

func getFirstPosIndx(_ arr: [Int]) -> Int {
    var l = 0
    var r = arr.count - 1
    
    var ans = -1
    
    while l <= r {
        let mid = l + ((r - l) / 2)
        
        if arr[mid] >= 0 {
            ans = mid
            r = mid - 1
        } else {
            l = mid + 1
        }
    }
    
    return ans
}

print(getFirstPosIndx([-7, -2, -1, -1, 1, 2, 2, 2, 3, 5])) // 4
print(getFirstPosIndx([-7, -2, -1, -1])) // -1
print(getFirstPosIndx([-7, 1, 2, 2, 2, 3, 5])) // 1
print(getFirstPosIndx([1, 2, 2, 2, 3, 5])) // 0

//print(sortSquares([-7, -2, -1, -1, 1, 2, 2, 2, 3, 5]))

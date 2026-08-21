// Ques: https://www.geeksforgeeks.org/dsa/k-th-element-two-sorted-arrays/
//

func getElement(_ arr1: [Int], _ arr2: [Int], _ k: Int) -> Int {
    if arr1.count > arr2.count {
        return getElement(arr2, arr1, k)
    }
    
    let n1 = arr1.count
    let n2 = arr2.count
    
    // Think of k = 6, if you wrote l = 0, what if there aren't enough elements on arr2, lets say it has 4, to make partition size 6, we still need 2 (i.e. k - n2) more elements, we can't pick from arr1, since l = 0. Therefore, l should be max(0, k - n2)
    var l = max(0, k - n2)
    var r = min(k, n1)      // Think of k = 1, if you wrote r = n1, then partition will be invalid if n1 > k
    
    while l <= r {
        let mid1 = l + ((r - l) / 2)
        let mid2 = k - mid1
        
        let l1 = mid1 == 0 ? Int.min : arr1[mid1 - 1]
        let l2 = mid2 == 0 ? Int.min : arr2[mid2 - 1]
        let r1 = mid1 == n1 ? Int.max : arr1[mid1]
        let r2 = mid2 == n2 ? Int.max : arr2[mid2]
        
        if l1 <= r2 && l2 <= r1 { return max(l1, l2) }
        
        if l1 > r2 {
            r = mid1 - 1
        } else {
            l = mid1 + 1
        }
    }
    
    return 0
}

func getElement2(_ arr1: [Int], _ arr2: [Int], _ k: Int, _ isFirstReversed: Bool) -> Int {
    if arr1.count > arr2.count {
        return getElement2(arr2, arr1, k, !isFirstReversed)
    }
    
    let n1 = arr1.count
    let n2 = arr2.count
    
    var l = max(0, k - n2)
    var r = min(n1, k)
    
    while l <= r {
        let mid1 = l + ((r - l) / 2)
        let mid2 = k - mid1
        
        var l1 = -1
        var r1 = -1
        var l2 = -1
        var r2 = -1
        
        if isFirstReversed {
            l1 = n1 - mid1 == 0 ? Int.min : arr1[n1 - mid1 - 1]
            r1 = n1 - mid1 == n1 ? Int.max : arr1[n1 - mid1]
            l2 = mid2 == 0 ? Int.min : arr2[mid2 - 1]
            r2 = mid2 == n2 ? Int.max : arr2[mid2]
        } else {
            l1 = mid1 == 0 ? Int.min : arr1[mid1 - 1]
            r1 = mid1 == n1 ? Int.max : arr1[mid1]
            l2 = n2 - mid2 == 0 ? Int.min : arr2[n2 - mid2 - 1]
            r2 = n2 - mid2 == n2 ? Int.max : arr2[n2 - mid2]
        }
        
        if l1 <= r2 && l2 <= r1 { return max(l1, l2) }
        
        if l1 > r2 {
            r = mid1 - 1
        } else {
            l = mid1 + 1
        }
    }
    
    return -1
}

//print(getElement([2, 3, 6, 7, 9], [1, 4, 8, 10], 6))

print(getElement2([9, 7, 6, 3, 2], [1, 4, 8, 10], 6, true))

func getMinSwaps(_ arr: [Int]) -> Int {
    var k = 0
    for val in arr {
        k += val
    }
    
    var curr = 0
    for i in 0 ..< k {
        curr += arr[i]
    }
    var maxOnes = curr
    for i in k ..< arr.count {
        curr += arr[i] - arr[i - k]
        maxOnes = max(maxOnes, curr)
    }
    
    return k - maxOnes
}

let arr = [0,1,1,0,1,0,1]
print(getMinSwaps(arr))



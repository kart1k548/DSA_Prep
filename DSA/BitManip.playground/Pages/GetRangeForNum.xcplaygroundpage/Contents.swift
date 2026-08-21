func getRange(_ num: Int) -> [Int] {
    var n = num
    let isPowerOf2: Bool = (n & (n - 1)) == 0
    var cnt = 0
    while n != 0 {
        n = n >> 1
        cnt += 1
    }
    cnt -= 1
    
    if isPowerOf2 {
        return [(1 << (cnt)), (1 << (cnt))]
    }
    
    return [(1 << (cnt)), (1 << (cnt + 1))]
}

print(getRange(1))

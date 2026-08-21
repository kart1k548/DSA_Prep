// Swap two nums without using extra variable
func swap() {
    var a = 10
    var b = 15
    
    a = a ^ b
    b = a ^ b
    a = a ^ b
    
    print(a) // 15
    print(b) // 10
}

swap()

// check ith bit is set or not
func checkisBitSet(_ num: Int, _ i: Int) -> Bool {
    return (num & (1 << i)) != 0
}

print(checkisBitSet(20, 2)) // true
print(checkisBitSet(20, 3)) // false

// set the ith bit
func setBit(_ num: Int, _ i: Int) {
    let newNum = (num | (1 << i))
    print(newNum)
}
setBit(5, 1) // 7
setBit(4, 4) // 20

// clear the ith bit
func clearBit(_ num: Int, _ i: Int) {
    let newNum = (num & (~(1 << i)))
    print(newNum)
}

clearBit(20, 2) // 16
clearBit(16, 4) // 0

// toggle the ith bit
func toggleBit(_ num: Int, _ i: Int) {
    let newNum = (num ^ (1 << i))
    print(newNum)
}

toggleBit(5, 1) // 7
toggleBit(7, 2) // 3

// clear the right most set bit
func clearLastSetBit(_ num: Int) {
    let newNum = (num & (num - 1))
    print(newNum)
}

clearLastSetBit(20) // 16
clearLastSetBit(16) // 0

// count the number of set bits
func countSetBits(_ num: Int) -> Int {
    var cnt = 0
    var n = num
    
    while n != 0 {
        n = (n & (n - 1))
        cnt += 1
    }
    
    return cnt
}

print(countSetBits(17)) // 2
print(countSetBits(15)) // 4
print(countSetBits(0)) // 0

// check if number is power of 2
func checkPowerOf2(_ num: Int) -> Bool {
    return (num & (num - 1) == 0)
}

print(checkPowerOf2(32)) // true
print(checkPowerOf2(28)) // false




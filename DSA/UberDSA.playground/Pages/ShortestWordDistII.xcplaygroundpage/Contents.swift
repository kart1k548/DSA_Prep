// Ques: https://www.lintcode.com/problem/925/?fromId=218&_from=collection
// Given a list of words (may contain duplicates), return the shortest distance between two words
struct Pair: Hashable {
    let word1: String
    let word2: String
    
    init(_ a: String, _ b: String) {
        if a < b {
            self.word1 = a
            self.word2 = b
        } else {
            self.word2 = a
            self.word1 = b
        }
    }
}

class WordDistance {
    private var indxMap = [String: [Int]]()
    private var cache = [Pair: Int]()
    
    func setWords(_ words: [String]) {
        let n = words.count
        
        for i in 0 ..< n {
            indxMap[words[i], default: []].append(i)
        }
    }
    
    public func shortest(_ word1: String, _ word2: String) -> Int {
        let indxArr1 = indxMap[word1]!
        let indxArr2 = indxMap[word2]!
        
        let key = Pair(word1, word2)
        if let diff = cache[key] {
            return diff
        }
        
        let smallestDiff = getSmallestDiff(indxArr1, indxArr2)
        cache[key] = smallestDiff
        
        return smallestDiff
    }
    
    private func getSmallestDiff(_ arr1: [Int], _ arr2: [Int]) -> Int {
        let n1 = arr1.count
        let n2 = arr2.count
        var i1 = 0
        var i2 = 0
        var minDiff = Int.max
        
        while i1 < n1 && i2 < n2 {
            let diff = abs(arr1[i1] - arr2[i2])
            minDiff = min(diff, minDiff)
            if arr1[i1] > arr2[i2] {
                i2 += 1
            } else {
                i1 += 1
            }
        }
        
        return minDiff
    }
}

let wd = WordDistance()
//wd.setWords(["practice", "makes", "perfect", "coding", "makes"])
//print(wd.shortest("practice", "coding"))
//print(wd.shortest("coding", "makes"))

wd.setWords(["quia", "blanditiis", "dolores", "sed", "tenetur", "eos", "unde", "tenetur", "blanditiis", "ducimus"])
print(wd.shortest("blanditiis", "tenetur")) // 1
print(wd.shortest("blanditiis", "dolores")) // 1
print(wd.shortest("unde", "eos")) // 1
print(wd.shortest("quia", "sed"))

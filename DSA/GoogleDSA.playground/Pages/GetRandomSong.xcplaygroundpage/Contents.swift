class RandomSongPicker {
    let songs = ["A", "B"]
    let k: Int
    private var q = [Int]()
    private var indxSet = Set<Int>()
    var qIndx = 0
    
    init(_ k: Int) {
        self.k = k
    }
    
    func getRandomSong() -> String {
        var currIndx = getRandomIndex()
        while indxSet.contains(currIndx) {
            currIndx = getRandomIndex()
        }
        
        indxSet.insert(currIndx)
        q.append(currIndx)
        
        if indxSet.count > k {
            indxSet.remove(q[qIndx])
            qIndx += 1
        }
        
        return songs[currIndx]
    }
    
    private func getRandomIndex() -> Int {
        return Int.random(in: 0 ..< songs.count)
    }
}

var picker = RandomSongPicker(1)

for _ in 0 ..< 10 {
    print(picker.getRandomSong())
}

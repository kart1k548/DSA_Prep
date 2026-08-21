// Ques: https://leetcode.com/discuss/post/8243609/uber-interview-experiencesoftware-engine-8hqs/
// Given list of ride shares sorted by timestamp
// Input: (logs: [1: ["A", "B"]; 3: ["C", "D"]; 8: ["B", "C"]; 10: ["A", "E"]; 20: ["B", "D"]], totalRiders: 5)
// Output: 10

class DisjointSet {
    private var size: [String: Int]
    private var par: [String: String]
    var connectedComps: Int
    
    init(_ totalPass: Int) {
        self.connectedComps = totalPass
        self.size = [:]
        self.par = [:]
    }
    
    func insert(_ node1: String, _ node2: String) {
        let ultPar1 = getUltPar(node1)
        let ultPar2 = getUltPar(node2)
        
        if ultPar1 == ultPar2 { return }
        
        if size[ultPar1] ?? 1 > size[ultPar2] ?? 1 {
            size[ultPar1] = (size[ultPar1] ?? 1)  + (size[ultPar2] ?? 1)
            par[ultPar2] = ultPar1
        } else {
            size[ultPar2] = (size[ultPar2] ?? 1) + (size[ultPar1] ?? 1)
            par[ultPar1] = ultPar2
        }
        
        connectedComps -= 1
    }
    
    func getUltPar(_ node: String) -> String {
        if node == (par[node] ?? node) { return node }
        
        let ultPar = getUltPar((par[node] ?? node))
        par[node] = ultPar
        
        return ultPar
    }
}

func getTimestamp(_ times: [Int], _ sharedPass: [[String]], _ totalPass: Int) -> Int {
    let ds = DisjointSet(totalPass)
    
    for i in 0 ..< sharedPass.count {
        ds.insert(sharedPass[i][0], sharedPass[i][1])
        
        if ds.connectedComps == 1 {
            return times[i]
        }
    }
    
    return -1
}

//let timestamp = getTimestamp([1, 3, 8, 10, 20], [["A", "B"], ["C", "D"], ["B", "C"], ["A", "E"], ["B", "D"]], 5)
//print(timestamp)

class DisjointSet2 {
    private var size: [String: Int]
    private var par: [String: String]
    
    init(_ passList: [String]) {
        self.par = [:]
        self.size = [:]
        
        passList.forEach {
            par[$0] = $0
            size[$0] = 1
        }
    }
    
    func union(_ node1: String, _ node2: String) {
        let ultPar1 = getUltPar(node1)
        let ultPar2 = getUltPar(node2)
        
        if ultPar1 == ultPar2 { return }
        
        if size[ultPar1]! > size[ultPar2]! {
            size[ultPar1] = size[ultPar1]! + size[ultPar2]!
            par[ultPar2] = ultPar1
        } else {
            size[ultPar2] = size[ultPar2]! + size[ultPar1]!
            par[ultPar1] = ultPar2
        }
    }
    
    func getUltPar(_ node: String) -> String {
        if node == par[node]! { return node }
        
        let ultPar = getUltPar(par[node]!)
        par[node] = ultPar
        
        return ultPar
    }
    
    func getSize(_ node: String) -> Int {
        return size[node]!
    }
}

func getTimestamp2(_ times: [Int], _ sharedPass: [[String]], _ passList: [String]) -> Int {
    let ds = DisjointSet2(passList)
    let n = times.count
    
    for i in 0 ..< n {
        let currTime = times[i]
        
        ds.union(sharedPass[i][0], sharedPass[i][1])
        let ultPar = ds.getUltPar(sharedPass[i][0])
        
        if ds.getSize(ultPar) == passList.count {
            return currTime
        }
    }
    
    return -1
}

let timestamp = getTimestamp2([1, 3, 8, 10, 20], [["A", "B"], ["C", "D"], ["B", "C"], ["A", "E"], ["B", "D"]], ["A", "B", "C", "D", "E"])
print(timestamp)

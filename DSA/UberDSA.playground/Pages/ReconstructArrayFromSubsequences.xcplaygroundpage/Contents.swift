// Construct an N sized array consisting of elements from 0 to N - 1 given K subsequences of that array.
// It can be assumed that at least one valid answer always exists.
// Follow-up: In case of multiple valid solutions, return the one that corresponds to the "lowest" value.
// (i.e. [0, 1, 2, 3] is lower than [0, 2, 1, 3])
// Input: N = 5; Subsequences: [[2, 4, 0], [3, 1, 0]]
// Output: [2, 3, 1, 4, 0]

struct Heap<Element> {
    private var elements: [Element]
    private let areSorted: ((Element, Element) -> Bool)
    
    init(_ elements: [Element] = [], sort areSorted: @escaping ((Element, Element) -> Bool)) {
        self.elements = elements
        self.areSorted = areSorted
        buildHeap()
    }
    
    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    
    private mutating func buildHeap() {
        for i in stride(from: (elements.count / 2) - 1, through: 0, by: -1) {
            downHeapify(index: i)
        }
    }
    
    mutating func insert(_ ele: Element) {
        elements.append(ele)
        upHeapify(index: elements.count - 1)
    }
    
    func peek() -> Element? {
        return elements.first
    }
    
    @discardableResult
    mutating func remove() -> Element? {
        guard !elements.isEmpty else { return nil }
        let ans = elements.first
        
        elements.swapAt(0, elements.count - 1)
        elements.removeLast()
        
        if !elements.isEmpty {
            downHeapify(index: 0)
        }
        
        return ans
    }
    
    private mutating func upHeapify(index: Int) {
        var curr = index
        var parent = self.parent(index: index)
        
        while curr > 0 && areSorted(elements[curr], elements[parent]) {
            elements.swapAt(curr, parent)
            curr = parent
            parent = self.parent(index: curr)
        }
    }
    
    private mutating func downHeapify(index: Int) {
        var parent = index
        while true {
            var leftChild = self.leftChild(index: parent)
            var rightChild = self.rightChild(index: parent)
            var candidate = parent
            
            if leftChild < elements.count && areSorted(elements[leftChild], elements[candidate]) {
                candidate = leftChild
            }
            
            if rightChild < elements.count && areSorted(elements[rightChild], elements[candidate]) {
                candidate = rightChild
            }
            
            if candidate == parent { return }
            
            elements.swapAt(candidate, parent)
            parent = candidate
        }
    }
    
    private func parent(index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func leftChild(index: Int) -> Int {
        return ((2 * index) + 1)
    }
    
    private func rightChild(index: Int) -> Int {
        return ((2 * index) + 2)
    }
}

func getSmallestArray(_ n: Int, _ subs: [[Int]]) -> [Int] {
    var graph = [Int: [Int]]()
    var indegree = Array(repeating: 0, count: n)
    var seenEdge = Set<[Int]>()
    
    for sub in subs {
        for i in 0 ..< (sub.count - 1) {
            if !seenEdge.contains([sub[i], sub[i + 1]]) {
                graph[sub[i], default: []].append(sub[i + 1])
                indegree[sub[i + 1]] += 1
                seenEdge.insert([sub[i], sub[i + 1]])
            }
        }
    }
    
    var heap = Heap<Int>(sort: <)
    for i in 0 ..< n {
        if indegree[i] == 0 {
            heap.insert(i)
        }
    }
    
    var res = [Int]()
    while !heap.isEmpty {
        var curr = heap.remove()!
        res.append(curr)
        
        for nbr in graph[curr] ?? [] {
            indegree[nbr] -= 1
            if indegree[nbr] == 0 {
                heap.insert(nbr)
            }
        }
    }
    
    return res
}

print(getSmallestArray(5, [[2, 4, 0], [3, 1, 0]]))

func getSmallestArray2(_ n: Int, _ subs: [[Int]]) -> [Int] {
    var indegree = Array(repeating: 0, count: n)
    var graph = [Int: [Int]]()
    
    for sub in subs {
        for i in 0 ..< (sub.count - 1) {
            let curr = sub[i]
            let nbr = sub[i + 1]
            graph[curr, default: []].append(nbr)
            indegree[nbr] += 1
        }
    }
    
    var q: Heap<Int> = .init(sort: <)
    for i in 0 ..< n {
        if indegree[i] == 0 {
            q.insert(i)
        }
    }
    
    var res = [Int]()
    while !q.isEmpty {
        let curr = q.remove()!
        
        res.append(curr)
        
        for nbr in graph[curr] ?? [] {
            indegree[nbr] -= 1
            if indegree[nbr] == 0 {
                q.insert(nbr)
            }
        }
    }
    
    return res
}

print(getSmallestArray2(5, [[2, 4, 0], [3, 1, 0]]))

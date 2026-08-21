// Ques: https://leetcode.com/discuss/post/7043175/uber-l5a-sse-interview-experience-by-nik-qpdr/

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

struct Deque<Element> {
    private var left: [Element] = []
    
    private var right: [Element] = []
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    
    mutating func pushFront(_ ele: Element) {
        left.append(ele)
    }
    
    mutating func pushBack(_ ele: Element) {
        right.append(ele)
    }
    
    mutating func popFront() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        
        return left.popLast()
    }
}

struct Pair: Comparable {
    var r: Int
    var c: Int
    var cost: Int
    
    init(_ r: Int, _ c: Int, _ cost: Int) {
        self.r = r
        self.c = c
        self.cost = cost
    }
    
    static func < (_ lhs: Pair, _ rhs: Pair) -> Bool {
        return lhs.cost < rhs.cost
    }
}

func getCost(_ grid: [[Int]]) -> Int {
    let m = grid.count
    let n = grid[0].count
    
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    
    let dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    
    var minCost = Int.max
    
    var hp = Heap<Pair>(sort: <)
    
    hp.insert(Pair(0, 0, 0))
    
    while !hp.isEmpty {
        var curr = hp.remove()!
        
        if visited[curr.r][curr.c] {
            continue
        }
        visited[curr.r][curr.c] = true
        
        if curr.r == m - 1 && curr.c == n - 1 {
            minCost = min(minCost, curr.cost)
        }
        
        for dir in dirs {
            let nr = curr.r + dir[0]
            let nc = curr.c + dir[1]
            
            if nr >= 0 && nc >= 0 && nr < m && nc < n && !visited[nr][nc] {
                var newCost = curr.cost
                switch grid[curr.r][curr.c] {
                    case 0: newCost = dir[0] == 0 && dir[1] == -1 ? newCost : newCost + 1
                    case 1: newCost = dir[0] == -1 && dir[1] == 0 ? newCost : newCost + 1
                    case 2: newCost = dir[0] == 0 && dir[1] == 1 ? newCost : newCost + 1
                    case 3: newCost = dir[0] == 1 && dir[1] == 0 ? newCost : newCost + 1
                    default: break
                }
                
                hp.insert(Pair(nr, nc, newCost))
            }
        }
    }
    
    return minCost
}

func getCost2(_ grid: [[Int]]) -> Int {
    let m = grid.count
    let n = grid[0].count
    let dirs = [[0,1], [0,-1], [1,0], [-1,0]]
    var q = Deque<Pair>()
    q.pushBack(Pair(0, 0, 0))
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    
    while !q.isEmpty {
        var curr = q.popFront()!
        
        if visited[curr.r][curr.c] {
            continue
        }
        visited[curr.r][curr.c] = true
        
        if curr.r == m - 1 && curr.c == n - 1 {
            return curr.cost
        }
        
        for dir in dirs {
            let nr = curr.r + dir[0]
            let nc = curr.c + dir[1]
            
            if nr < 0 || nr >= m || nc < 0 || nc >= n { continue }
            
            switch grid[curr.r][curr.c] {
            case 0:
                if dir[0] == 0 && dir[1] == -1 {
                    q.pushFront(Pair(nr, nc, curr.cost))
                    continue
                }
            case 1:
                if dir[0] == -1 && dir[1] == 0 {
                    q.pushFront(Pair(nr, nc, curr.cost))
                    continue
                }
            case 2:
                if dir[0] == 0 && dir[1] == 1 {
                    q.pushFront(Pair(nr, nc, curr.cost))
                    continue
                }
            case 3:
                if dir[0] == 1 && dir[1] == 0 {
                    q.pushFront(Pair(nr, nc, curr.cost))
                    continue
                }
            default: break
            }
            q.pushBack(Pair(nr, nc, curr.cost + 1))
        }
        
    }
    
    return -1
}

print(
    getCost2(
        [
            [1, 0, 1],
            [3, 1, 3],
            [1, 3, 3]
        ]
    )
)


func dfs(_ curr: Int, _ prev: Int) -> Bool {
    if visited.contains(curr) {
        cycleStart = curr
        return true
    }
    visited.insert(curr)
    
    for nbr in graph[curr] ?? [] {
        if nbr != prev {
            if dfs(nbr, curr) {
                if cycStart != -1 {
                    cycleSet.insert(curr)
                    if cycleStart == curr {
                        cycleStart = -1
                    }
                }
                return true
            }
        }
    }
    
    return false
}

func dfs(_ curr: Int) {
    while !(graph[curr] ?? []).isEmpty {
        let next = graph[curr].removeLast()
        dfs(next)
    }
    
    res.append(curr)
}


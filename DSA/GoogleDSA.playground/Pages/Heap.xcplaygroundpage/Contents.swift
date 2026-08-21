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

var heap = Heap<Int>(sort: <)

heap.insert(0)
heap.insert(5)
heap.insert(1)
heap.insert(8)
heap.insert(9)

print(heap.peek())
print(heap.remove())

// MARK: - AVL Tree Node
class AVLNode<T: Comparable> {
    var value: T
    var left: AVLNode?
    var right: AVLNode?
    var height: Int = 1

    init(_ value: T) {
        self.value = value
    }
}

// MARK: - AVL Tree
struct AVLTree<T: Comparable> {
    private var root: AVLNode<T>?

    // MARK: Height & Balance Factor
    private func height(_ node: AVLNode<T>?) -> Int {
        node?.height ?? 0
    }

    private func balanceFactor(_ node: AVLNode<T>?) -> Int {
        guard let node else { return 0 }
        return height(node.left) - height(node.right)
    }

    private func updateHeight(_ node: AVLNode<T>) {
        node.height = 1 + max(height(node.left), height(node.right))
    }

    // MARK: - Rotations
    private func rotateRight(_ curr: AVLNode<T>) -> AVLNode<T> {
        let leftChild = curr.left!
        let rightChildOfLC = leftChild.right

        leftChild.right = curr
        curr.left = rightChildOfLC

        updateHeight(curr)
        updateHeight(leftChild)
        return leftChild
    }

    private func rotateLeft(_ curr: AVLNode<T>) -> AVLNode<T> {
        let rightChild = curr.right!
        let leftChildOfRC = rightChild.left

        rightChild.left = curr
        curr.right = leftChildOfRC

        updateHeight(curr)
        updateHeight(rightChild)
        return rightChild
    }

    // MARK: - Rebalance
    private func rebalance(_ node: AVLNode<T>) -> AVLNode<T> {
        updateHeight(node)
        let bf = balanceFactor(node)

        // Left Heavy
        if bf > 1 {
            if balanceFactor(node.left) < 0 {
                node.left = rotateLeft(node.left!) // Left-Right case
            }
            return rotateRight(node)
        }

        // Right Heavy
        if bf < -1 {
            if balanceFactor(node.right) > 0 {
                node.right = rotateRight(node.right!) // Right-Left case
            }
            return rotateLeft(node)
        }

        return node // Already balanced
    }

    // MARK: - Insert → O(log N)
    mutating func insert(_ value: T) {
        root = insert(root, value)
    }

    private func insert(_ node: AVLNode<T>?, _ value: T) -> AVLNode<T> {
        guard let node else { return AVLNode(value) }

        if value < node.value {
            node.left = insert(node.left, value)
        } else if value > node.value {
            node.right = insert(node.right, value)
        } else {
            return node // Duplicate: ignored (unique elements guaranteed)
        }

        return rebalance(node)
    }

    // MARK: - Delete → O(log N)
    mutating func delete(_ value: T) {
        root = delete(root, value)
    }

    private func delete(_ node: AVLNode<T>?, _ value: T) -> AVLNode<T>? {
        guard let node else { return nil }

        if value < node.value {
            node.left = delete(node.left, value)
        } else if value > node.value {
            node.right = delete(node.right, value)
        } else {
            // Node found
            if node.left == nil { return node.right }
            if node.right == nil { return node.left }

            // Replace with in-order successor (smallest in right subtree)
            let successor = minNode(node.right!)
            node.value = successor.value
            node.right = delete(node.right, successor.value)
        }

        return rebalance(node)
    }

    private func minNode(_ node: AVLNode<T>) -> AVLNode<T> {
        var current = node
        while let left = current.left { current = left }
        return current
    }

    // MARK: - Contains → O(log N)
    func contains(_ value: T) -> Bool {
        var current = root
        while let node = current {
            if value == node.value { return true }
            current = value < node.value ? node.left : node.right
        }
        return false
    }

    // MARK: - In-order traversal (returns sorted array)
    func toSortedArray() -> [T] {
        var result: [T] = []
        inorder(root, &result)
        return result
    }

    private func inorder(_ node: AVLNode<T>?, _ result: inout [T]) {
        guard let node else { return }
        inorder(node.left, &result)
        result.append(node.value)
        inorder(node.right, &result)
    }
}

var stream = AVLTree<Int>()

// Simulate a data stream
// Right Rotation: [3, 2, 1], (Place a pin at 3 and pull the thread from right)
// Left-Right Rotation: [3, 1, 2], (Place the pin at 1 and pull the thread from left, then place pin at 3 and pull from right)
// Left Rotation: [1, 2, 3], (Place a pin at 1 and pull the thread from left)
// Right-Left Rotation: [1, 3, 2], (Place the pin at 3 and pull the thread from right, then place pin at 1 and pull from left)
for value in [15, 10, 20, 8, 12, 25, 5] {
    stream.insert(value)
}

print(stream.toSortedArray()) // [5, 8, 10, 12, 15, 20, 25]

stream.delete(10)
print(stream.toSortedArray()) // [5, 8, 12, 15, 20, 25]

print(stream.contains(12))   // true
print(stream.contains(10))

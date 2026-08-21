// Ques: https://www.interviewbit.com/uber-interview-questions/#write-functional-code-for-solving-the-problem
// Given an undirected tree, each node is assigned a weight. We must remove an edge in such a way that the difference between the sum of weights in one subtree and the sum of weights in the other subtree is as small as possible.

//So for the example given below, we have to remove an edge to reduce the subtree sum difference.
//
//We have 6 edge deletion options in the below given tree:
//edge 0-1,  subtree sum difference = 21 - 2 = 19
//edge 0-2,  subtree sum difference = 14 - 9 = 5
//edge 0-3,  subtree sum difference = 15 - 8 = 7
//edge 2-4,  subtree sum difference = 20 - 3 = 17
//edge 2-5,  subtree sum difference = 18 - 5 = 13
//edge 3-6,  subtree sum difference = 21 - 2 = 19
//
//Clearly, we should remove the edge 0-2 in an optimal solution.


class TreeNode {
    var id: Int
    var wt: Int
    private(set) var childs: [TreeNode]
    
    init(_ id: Int, _ wt: Int, _ childs: [TreeNode] = []) {
        self.id = id
        self.wt = wt
        self.childs = childs
    }
    
    func addChild(_ node: TreeNode) {
        childs.append(node)
    }
}

func getMinimumDiff(_ root: TreeNode) -> Int {
    var totalSum = 0
    
    func dfs(_ node: TreeNode) {
        totalSum += node.wt
        for child in node.childs {
            dfs(child)
        }
    }
    
    dfs(root)
    
    var minDiff = Int.max
    
    func getSum(_ node: TreeNode) -> Int {
        
        var sum = 0
        for child in node.childs {
            sum += getSum(child)
        }
        
        let total = sum + node.wt
        if total != totalSum {
            minDiff = min(minDiff, abs(totalSum - (2 * total)))
        }
        return total
    }
    
    _ = getSum(root)
    
    return minDiff
}

func buildTree(_ edges: [[Int]], _ rootId: Int, _ wts: [Int: Int]) -> TreeNode {
    var nodes = [Int: TreeNode]()
    
    func node(_ id: Int) -> TreeNode {
        if let existing = nodes[id] {
            return existing
        }
        
        let newNode = TreeNode(id, wts[id]!)
        nodes[id] = newNode
        
        return newNode
    }
    
    for edge in edges {
        var par = node(edge[0])
        let child = node(edge[1])
        par.addChild(child)
    }
    
    return node(rootId)
}

let root = buildTree([[0, 1], [0, 2], [0, 3], [2, 4], [2, 5], [3, 6]], 0, [0: 4, 1: 2, 2: 1, 3: 6, 4: 3, 5: 5, 6: 2])

print(getMinimumDiff(root))



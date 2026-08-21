// Append all the nodes with indegree of 0 to bfs queue
// REMOVE, the element and add it to ans
// WORK* and ADD*, decrease the indegree of the children, add to q only if the indegree of child is 0

func getTopoSortOrder(_ edges: [[Int]], _ nodes: Int) -> [Int] {
    var graph = [Int: [Int]]()
    var indegree = Array(repeating: 0, count: nodes)
    
    for edge in edges {
        graph[edge[0], default: []].append(edge[1])
        indegree[edge[1]] += 1
    }
    
    var q = [Int]()
    
    for i in 0 ..< nodes {
        if indegree[i] == 0 {
            q.append(i)
        }
    }
    
    var res = [Int]()
    
    while !q.isEmpty {
        var childs = [Int]()
        
        for indx in 0 ..< q.count {
            let curr = q[indx]
            res.append(curr)
            
            for child in graph[curr] ?? [] {
                indegree[child] -= 1
                if indegree[child] == 0 {
                    childs.append(child)
                }
            }
        }
        
        q = childs
    }
    
    return res.count == nodes ? res : []    // returns [], if there is a cycle
}

let edges = [[5,0], [4,0], [4,1], [3,1], [2,3], [5,2]]
let nodes = 6
//let edges = [[0,1], [1,2], [2,3], [2,4], [3,1]]
//let nodes = 5
print(getTopoSortOrder(edges, nodes))


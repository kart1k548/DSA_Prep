// Ques: https://www.youtube.com/watch?v=Rn6B-Q4SNyA
// Initially for grid containing all water. Place a land at the curr query pos, after that append the number of islands in the res array
// Input: grid size -> m: 4, n: 5; and queries array [[0,0], [0,0], [1,1], [1,0], [0,1], [0,3], [1,3], [0,4], [3,2], [2,2], [1,2], [0,2]]
// Output: res -> [1, 1, 2, 1, 1, 2, 2, 2, 3, 3, 1, 1]

class DisjointSet {
    private var size: [Int]
    private var par: [Int]
    
    init(_ n: Int) {
        self.size = Array(repeating: 1, count: n)
        self.par = Array(0 ..< n)
    }
    
    func union(_ node1: Int, _ node2: Int) {
        let ultPar1 = getUltPar(node1)
        let ultPar2 = getUltPar(node2)
        
        if ultPar1 == ultPar2 { return }
        
        if size[ultPar1] > size[ultPar2] {
            par[ultPar2] = ultPar1
            size[ultPar1] += size[ultPar2]
        } else {
            par[ultPar1] = ultPar2
            size[ultPar2] += size[ultPar1]
        }
    }
    
    func getUltPar(_ node: Int) -> Int {
        if node == par[node] { return node }
        
        let ultPar = getUltPar(par[node])
        par[node] = ultPar
        return ultPar
    }
}

func getIslands(_ m: Int, _ n: Int, _ queries: [[Int]]) -> [Int] {
    var res = [Int]()
    var grid = Array(repeating: Array(repeating: 0, count: n), count: m)
    var islands = 0
    let dirs = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    var ds = DisjointSet((m * n))
    
    for query in queries {
        let r = query[0]
        let c = query[1]
        
        if grid[r][c] == 0 {
            grid[r][c] = 1
            islands += 1
            
            for dir in dirs {
                let nr = r + dir[0]
                let nc = c + dir[1]
                
                if nr < 0 || nr >= m || nc < 0 || nc >= n || grid[nr][nc] == 0 { continue }
                
                let currNode = (n * r) + c
                let nbrNode = (n * nr) + nc
                let currUltPar = ds.getUltPar(currNode)
                let nbrUltPar = ds.getUltPar(nbrNode)
                if currUltPar != nbrUltPar {
                    islands -= 1
                    ds.union(currNode, nbrNode)
                }
            }
        }
        
        res.append(islands)
    }
    
    return res
}

print(getIslands(4, 5, [[0,0], [0,0], [1,1], [1,0], [0,1], [0,3], [1,3], [0,4], [3,2], [2,2], [1,2], [0,2]]))


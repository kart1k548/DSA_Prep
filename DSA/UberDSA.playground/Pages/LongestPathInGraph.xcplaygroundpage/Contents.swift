// Ques: https://leetcode.com/discuss/post/8243609/uber-interview-experiencesoftware-engine-8hqs/
// Input: Chennai -> Hyderabad, Hyderabad -> Bangalore, Bangalore -> Delhi, Hyderabad -> Delhi
// Output: Chennai->Hyderabad->Bangalore->Delhi

func getLongestJourney(_ flights: [[String]]) -> [String] {
    var graph = [String: [String]]()
    
    for flight in flights {
        let src = flight[0]
        let dest = flight[1]
        
        graph[src, default: []].append(dest)
    }
    
    var longestPath = [String]()
    var memo = [String: [String]]()
    
    // expectation: dfs func will return the longest path from curr node
    func dfs(_ curr: String) -> [String] {
        if let cachedPath = memo[curr] {
            return cachedPath
        }
        
        var best = [String]()
        for nbr in graph[curr] ?? [] {
            let candidate = dfs(nbr)
            if best.count < candidate.count {
                best = candidate
            }
        }
        
        let longestPathFromCurr = [curr] + best
        memo[curr] = longestPathFromCurr
        
        return longestPathFromCurr
    }
    
    for node in graph.keys {
        let candidate = dfs(node)
        
        if candidate.count > longestPath.count {
            longestPath = candidate
        }
    }
    
    return longestPath
}
//
//let path = getLongestJourney([["C", "A"], ["C", "H"], ["H", "B"], ["B", "D"], ["H", "D"]])
//print(path)

func getLongestJourney2(_ flights: [[String]]) -> [String] {
    var graph = [String: [String]]()
    
    for flight in flights {
        graph[flight[0], default: []].append(flight[1])
    }
    
    var memo = [String: [String]]()
    func dfs(_ curr: String) -> [String] {
        if let cachedPath = memo[curr] {
            return cachedPath
        }
        
        var best = [String]()
        
        for nbr in graph[curr] ?? [] {
            let candidate = dfs(nbr)
            if candidate.count > best.count {
                best = candidate
            }
        }
        
        let fullPath = [curr] + best
        memo[curr] = fullPath
        
        return fullPath
    }
    
    var longestPath = [String]()
    
    for node in graph.keys {
        let candidate = dfs(node)
        
        if candidate.count > longestPath.count {
            longestPath = candidate
        }
    }
    
    return longestPath
}

let path = getLongestJourney2([["C", "A"], ["C", "H"], ["H", "B"], ["B", "D"], ["H", "D"]])
print(path)

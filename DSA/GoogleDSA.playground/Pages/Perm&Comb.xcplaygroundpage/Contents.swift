func comb1(_ n: Int, _ k: Int) -> [String] {
    var res = [String]()
    
    func backtrack(_ level: Int, _ ans: String, _ cnt: Int) {
      if level > n {
        if cnt == 2 {
          res.append(ans)
        }
        return
      }
      
      backtrack(level + 1, ans + "i", cnt + 1)
      backtrack(level + 1, ans + "_", cnt)
    }
    
    backtrack(1, "", 0)
    
    return res
}

print(comb1(5, 2))

func perm1(_ n: Int, _ k: Int) -> [String] {
  var res = [String]()
  var ans: [Character] = Array(repeating: "_", count: n)
  
  func backtrack(_ ci: Int) {
    if ci > k {
      res.append(String(ans))
      return
    }
    
    for i in 0 ..< n {
      if ans[i] == "_" {
        ans[i] = Character("\(ci)")
        backtrack(ci + 1)
        ans[i] = "_"
      }
    }
  }
  
  backtrack(1)
  
  return res
}

print(perm1(5, 2))

func comb2(_ n: Int, _ k: Int) -> [String] {
    var res = [String]()
    var ans: [Character] = Array(repeating: "_", count: n)
    
    func backtrack(_ lastPlaced: Int, _ ci: Int) {
      if ci > k {
        res.append(String(ans))
        return
      }
      
      for i in (lastPlaced + 1) ..< n {
        if ans[i] == "_" {
          ans[i] = Character("i")
          backtrack(i, ci + 1)
          ans[i] = "_"
        }
      }
    }
    
    backtrack(-1, 1)
    
    return res
}

print(comb2(5, 2))

func perm2(_ n: Int, _ k: Int) -> [String] {
  var res = [String]()
  var visited = Set<Int>()
  
  func backtrack(_ level: Int, _ ans: String) {
    if level == n {
        if visited.count == k {
            res.append(ans)
        }
      return
    }
    
    for ci in 1 ..< (k + 1) {
      if !visited.contains(ci) {
        visited.insert(ci)
        backtrack(level + 1, ans + "\(ci)")
        visited.remove(ci)
      }
    }
    
    backtrack(level + 1, ans + "_")
  }
  
  backtrack(0, "")
  
  return res
}

print(perm2(5, 2))

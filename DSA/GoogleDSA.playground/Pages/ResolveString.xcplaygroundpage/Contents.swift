// Ques: https://leetcode.com/discuss/post/5676384/google-onsite-interview-l4-by-anonymous_-eobb/
// x = "new"
// y = "%xworld"
// z = "hello"
// example resolveString("%z_%x_%y_world")
// output: hello_new_newworld_world

// Take a helper resolve func which can go recursive to resolve %_ chars
// Start the iteration, with i = 0
// 1) check if current char is "%" && i + 1 < n, if yes
//     - get the val for varName(i.e. char at (i + 1)), if no val, then move
//     - Now, for cycles check if varName is already present in set, if yes, then move i += 2 and continue
//     - If not present, then just insert current varName, and expect the resolved string by recursive call from resolve(value, &visiting)
//     - remove the varName from visiting while backtracking
//     - At last just move i += 1 to skip "%", don't worry about varName, it will be skipped by very last i += 1 in while loop
// 2) If no, then append the curr char in ans only if it is != "%" (we dont want % in ans)
// 3) At last move i += 1
// Exit the loop, and just return ans

class Resolver {
    private var vars: [Character: String] = [:]
    
    func updateVariable(_ varName: Character, _ value: String) {
        vars[varName] = value
    }
    
    func resolveString(_ input: String) -> String {
        var set = Set<Character>()
        return resolve(input, &set)
    }
    
    private func resolve(_ str: String, _ visiting: inout Set<Character>) -> String {
        var ans = ""
        let n = str.count
        var str = Array(str)
        var i = 0
        
        while i < n {
            if str[i] == "%" && (i + 1) < n {
                let varName = str[i + 1]
                if let value = vars[varName] {
                    if visiting.contains(varName) {
                        i += 2
                        continue
                    }
                    
                    visiting.insert(varName)
                    let resolved = resolve(value, &visiting)
                    visiting.remove(varName)
                    
                    ans += resolved
                    i += 1
                }
            } else {
                ans += str[i] == "%" ? "" : String(str[i])
            }
            i += 1
        }
        
        return ans
    }
}

let r = Resolver()

r.updateVariable("b", "%a%src")
r.updateVariable("a", "data%c%")
r.updateVariable("c", "base")

print(r.resolveString("hello%b%"))

//r.updateVariable("x", "new")
//r.updateVariable("y", "%xworld")
//r.updateVariable("z", "hello")
//
//print(r.resolveString("%z_%x_%y_world"))


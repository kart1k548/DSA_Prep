// Ques: https://leetcode.com/discuss/post/6058077/google-l4-on-site-bangalore-by-anonymous-gimt/
// Meetings: [(1, 7), (5, 10), (12, 30), (22, 30), (40, 50), (60, 70)]
// DNS: (18, 25)
// Sample output: [(1, 10), (12, 18), (25, 30), (40, 50), (60, 70)]


func scheduleMeetings(_ intervals: [[Int]], _ dnsInterval: [Int]) -> [[Int]] {
    var filteredEvents = filterEvents(intervals, dnsInterval)
    
    if filteredEvents.isEmpty { return [] }
    
    var sortedEvents = filteredEvents.sorted(by: { $0[0] < $1[0] })
    
    var stk = [[Int]]()
    stk.append(sortedEvents[0])
    
    for i in 1 ..< sortedEvents.count {
        let interval = sortedEvents[i]
        var currStart = interval[0]
        var currEnd = interval[1]
        if let prevInterval = stk.last, currStart >= prevInterval[1] {
            stk.append(interval)
        } else {
            let prev = stk.removeLast()
            var newInterval = [Int]()
            newInterval.append(prev[0])
            newInterval.append(max(prev[1], currEnd))
            stk.append(newInterval)
        }
    }
    
    return stk
}

func filterEvents(_ intervals: [[Int]], _ dnsInterval: [Int]) -> [[Int]] {
    var res = [[Int]]()
    
    for interval in intervals {
        var currStartTime = interval[0]
        var currEndTime = interval[1]
        var dnsStart = dnsInterval[0]
        var dnsEnd = dnsInterval[1]
        
        if currEndTime <= dnsStart || currStartTime >= dnsEnd {
            res.append(interval)
        } else {
            if currStartTime >= dnsStart && currEndTime <= dnsEnd { continue }
            if currStartTime >= dnsStart {
                var newInterval = [Int]()
                newInterval.append(dnsEnd)
                newInterval.append(currEndTime)
                res.append(newInterval)
            } else {
                if currEndTime <= dnsEnd {
                    var newInterval = [Int]()
                    newInterval.append(currStartTime)
                    newInterval.append(dnsStart)
                    res.append(newInterval)
                } else {
                    var newLeftInterval = [Int]()
                    var newRightInterval = [Int]()
                    newLeftInterval.append(currStartTime)
                    newLeftInterval.append(dnsStart)
                    newRightInterval.append(dnsEnd)
                    newRightInterval.append(currEndTime)
                    res.append(newLeftInterval)
                    res.append(newRightInterval)
                }
            }
        }
    }
    
    return res
}

let intervals = [[1, 7], [5, 10], [12, 30], [22, 30], [40, 50], [60, 70]]
let dnsInterval = [18, 25]
print(scheduleMeetings(intervals, dnsInterval))

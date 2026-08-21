// Ques: https://leetcode.com/discuss/post/5670972/google-l4-onsite-by-anonymous_user-xnj8/

// Create an Event Struct
// - (time: Int) to store the time(could be either start/end)
// - (name: String) to store the name of employee on call
// - (isStart: Bool) to store whether it start/end time

// Iterate over the schedules and create array of events
// sort the array of events based on time
// Take three vars
// - result: [(Int, Int, [String])] to store final ans
// - active = Set<String>() to track list of employees currently on call
// - prevTime: Int? to track time of prev event during iteration
// Now, iterate over events array
// 1) Check if prevTime < currentEventTime && there are active on call employees, only then append (prevTime, currTime, list of employees) to result
// 2) Check if curr event isStart, if yes, insert curr employee in active set else remove curr employee from active set
// 3) At last assign prevTime to curr time
// Exit the loop and return result

struct Event {
    let time: Int
    let name: String
    let isStart: Bool
}

func onCallSchedule(_ schedules: [(String, Int, Int)]) -> [(Int, Int, [String])] {
    var events: [Event] = []
    
    for (name, start, end) in schedules {
        events.append(Event(time: start, name: name, isStart: true))
        events.append(Event(time: end, name: name, isStart: false))
    }
    
    // Sort: time first, then start before end
    events.sort {
        return $0.time < $1.time
    }
    
    var result: [(Int, Int, [String])] = []
    var active = Set<String>()
    
    var prevTime: Int? = nil
    
    for event in events {
        if let prev = prevTime, prev < event.time, !active.isEmpty {
            result.append((prev, event.time, Array(active).sorted()))
        }
        
        if event.isStart {
            active.insert(event.name)
        } else {
            active.remove(event.name)
        }
        
        prevTime = event.time
    }
    
    return result
}

let schedules = [
    ("Abby", 1, 10),
    ("Ben", 5, 7),
    ("Carla", 6, 12),
    ("David", 15, 17)
]

print(onCallSchedule(schedules))

//: Playground - noun: a place where people can play

import UIKit

struct Character {
    var name: String
    var level: Int
    var children: [Character]
    var familySize: Int {
        return 1 + children.map({ $0.familySize }).reduce(0, combine: +)
    }
    
    mutating func levelUp() {
        level += 1
    }
    
    init(name: String) {
        self.name = name
        self.level = 1
        self.children = []
    }
}

var characters = [Character]()

var alice = Character(name: "Alice")

var temp = alice
temp.name = "Bob"

alice.levelUp()

characters.append(alice)
characters.append(temp)

//--------------------------------------------------//

var andy = Character(name: "Andy")

alice.children.append(andy)

alice.familySize

alice.children.append(alice)

alice.familySize


//--------------------------------------------------//



struct Point: Equatable {
    var x: Double
    var y: Double
    var z: Double
    
    mutating func offset(x: Double, y: Double, z: Double) {
        self.x += x
        self.y += y
        self.z += z
    }
}

func ==(lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == lhs.y && lhs.z == lhs.z
}


var pt1 = Point(x: 2, y: 4, z: 6)
var pt2 = Point(x: 1, y: 2, z: 3)

pt2.offset(1, y: 2, z: 3)
pt2.offset(1, y: 2, z: 3)

pt1 == pt2


//--------------------------------------------------//


typealias PointTuple = (x: Double, y: Double, z: Double)

var pt3: PointTuple = (x: 1, y: 2, z: 3)
var pt4: PointTuple = (-1, -2, -3)

pt4.x *= -1
pt4.y *= -1
pt4.z *= -1

pt3 == pt4


//--------------------------------------------------//


enum GameStatus: String {
    case FINISHED = "DONE"
    case WAITING // = "WAITING"
    case PLAYING // = "PLAYING"
}

var statusString = "WAITING"

func parseGameStatusObject(string: String) -> GameStatus {
    guard let gameStatus = GameStatus(rawValue: statusString) else {
        // Assume invalid data is finished
        return .FINISHED
    }
    
    return gameStatus
}


let status = parseGameStatusObject(statusString)


switch status {
case .FINISHED:
    print("Game is finished!")
case .WAITING:
    print("Waiting other opponent")
case .PLAYING:
    print("Game is already active")
}


status.rawValue


//--------------------------------------------------//



struct Thermostat {
    enum State {
        case Cooling(Int)
        case Heating(Int)
        case CoolingAndHeating(Int, Int)
        case LowPower
        case PoweredOff
        
        var userDescription: String {
            switch self {
            case .Cooling:
                return "Cooling"
            case .Heating:
                return "Heating"
            case .CoolingAndHeating:
                return "Cooling and Heating"
            case .LowPower:
                return "Temperature is within thermostat bounds"
            case .PoweredOff:
                return "Powered Off"
            }
        }
    }
    
    var location: String
    var state: State
}


let thermostat = Thermostat(location: "Bedroom", state:
    .CoolingAndHeating(70, 75))

switch thermostat.state {
case let .Cooling(temp):
    print("Cooling to temperature: \(temp)")
case let .CoolingAndHeating(temp, _):
    print("Cooling to temperature: \(temp)")
default:
    print("Not cooling")
}

//--------------------------------------------------//

enum LinkedList: CustomDebugStringConvertible {
    case End
    indirect case Node(Int, LinkedList)
    
    mutating func construct(value: Int) -> LinkedList {
        self = Node(value, self)
        return self
    }
    
    mutating func pop() -> Int? {
        switch self {
        case .End:
            return nil
        case let .Node(value, next):
            self = next
            return value
        }
    }
    
    var debugDescription: String {
        switch self {
        case .End:
            return "<END>"
        case let .Node(value, next):
            return "\(value) \(next)"
        }
    }
}

var list = LinkedList.End
list.construct(1)
list.construct(2)
var list2 = list

list.pop()

list
list2








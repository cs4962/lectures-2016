//: Playground - noun: a place where people can play

import UIKit

struct Character {
    var name: String
    var level: Int
    var children: [Character]
    var familySize: Int {
        return 1 + children.map({ $0.familySize })
            .reduce(0, combine: +)
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

characters

///

var andy = Character(name: "Andy")

alice.children.append(andy)

alice.familySize

alice.children.append(alice)

alice.familySize


var integers = [1, 2, 3]

for i in integers {
    integers.append(i * 2)
}

integers


///


struct Vector: Equatable {
    var x: Double
    var y: Double
    var z: Double
    
    mutating func scaleBy(x: Double, y: Double, z: Double) {
        self.x *= x
        self.y *= y
        self.z *= z
    }
}

func ==(lhs: Vector, rhs: Vector) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

var vector1 = Vector(x: 2, y: 3, z: 6)
var vector2 = Vector(x: 1, y: 2, z: 3)

vector2.scaleBy(2, y: 1.5, z: 2)

vector1
vector2

vector1 == vector2

///

// tuple vectors
var tVector1: (Double, Double, Double) = (2, 3, 6)
var tVector2: (Double, Double, Double) = (2, 3, 6)

tVector2.2 = 3

tVector1 == tVector2

///

enum GameState: String {
    case FINISHED = "DONE"
    case WAITING // = "WAITING"
    case PLAYING
    
    var canJoin: Bool {
        switch self {
        case .WAITING:
            return true
        default:
            return false
        }
    }
}

GameState.FINISHED.rawValue
GameState.WAITING.rawValue
GameState.PLAYING.rawValue

GameState.FINISHED.canJoin
GameState.WAITING.canJoin

var gameStateString = "WAITING"

func parseGameState(gameStateString: String) -> GameState {
    guard let state = GameState(rawValue: gameStateString) else {
        // assume it's finished
        return .FINISHED
    }
    
    return state
}

parseGameState(gameStateString).canJoin


///

struct Thermostat {
    enum State {
        case PoweredOff
        case Idle(Int)
        case Cooling(Int)
        case Heating(Int)
    }
    
    var location: String
    var idNumber: Int

    var currentTemperature: Int {
        didSet {
            switch state {
            case let .Idle(targetTemperature):
                if currentTemperature < targetTemperature {
                    self.state = .Cooling(targetTemperature)
                }
                else {
                    self.state = .Heating(targetTemperature)
                }
            case .PoweredOff:
                fallthrough
            default:
                break
            }
        }
    }
    
    var state: State
}

var thermostat = Thermostat(location: "Family Room", idNumber: 2, currentTemperature: 72, state: .Cooling(68))

switch thermostat.state {
case .PoweredOff:
    print("Powered Off")
case .Idle:
    print("Idle")
case let .Cooling(temp):
    print("Cooling to temp: \(temp)")
case .Heating(let temp):
    print("Heating to temp: \(temp)")
}

switch thermostat.state {
case let .Cooling(temp):

if case let .Cooling(temp) = thermostat.state {
    print(temp)
}

///

enum LinkedList: CustomDebugStringConvertible {
    case EndNode
    indirect case ValueNode(Int, LinkedList)
    
    // append
    mutating func cons(value: Int) -> LinkedList {
        self = ValueNode(value, self)
        return self
    }
    
    mutating func pop() -> Int? {
        switch self {
        case .EndNode:
            return nil
        case let .ValueNode(value, next):
            self = next
            return value
        }
    }
    
    var debugDescription: String {
        switch self {
        case .EndNode:
            return "<END>"
        case let .ValueNode(value, next):
            return "\(value) \(next.debugDescription)"
        }
    }
}

var list: LinkedList = .EndNode

list.cons(1)
list.cons(2)
list.cons(3)
list.cons(4)
list.cons(5)

var list2 = list

list

list.pop()
list.pop()
list.pop()

list
list2



















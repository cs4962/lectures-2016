//: Playground - noun: a place where people can play

import Foundation

protocol UnitsConvertible {
    var factor: Double { get }
}

extension UnitsConvertible {
    func convertTo(value: Double, toUnits: Self) -> Double {
        return value * self.factor / toUnits.factor
    }
    
    func convertFrom(value: Double, fromUnits: Self) -> Double {
        return fromUnits.convertTo(value, toUnits: self)
    }
}

enum MetricPrefix: Int {
    case Nano = -9
    case Micro = -6
    case Milli = -3
    case Centi = -2
    case None = 0
    case Kilo = 3
    case Mega = 6
    case Giga = 9
    case Terra = 12
}

enum Length: UnitsConvertible {
    case Meters(MetricPrefix)
    case Feet
    case Inches
    case Yards
    case Miles
    
    var factor: Double {
        // Base unit (Meters)
        
        switch self {
        case let .Meters(prefix):
            return pow(10, Double(prefix.rawValue))
        case Feet:
            return 0.3048
        case Inches:
            return 0.0254
        case Yards:
            return 0.9144
        case Miles:
            return 1609.344
        }
    }
}

enum Weight: UnitsConvertible {
    case Grams(MetricPrefix)
    case Ounces
    case Pounds
    case Stones
    case Tons
    
    var factor: Double {
        // Base unit (Kilograms)

        switch self {
        case let .Grams(prefix):
            return pow(10, Double(prefix.rawValue - 3))
        case .Ounces:
            return 0.028349523125
        case .Pounds:
            return 0.45359237
        case .Stones:
            return 6.35029318
        case .Tons:
            return 907.18474
        }
    }
}

enum Bytes: Double, UnitsConvertible {
    case Bytes = 1
    case Kilobytes = 1024
    case Megabytes = 1048576
    case Gigabytes = 1073741824
    
    var factor: Double {
        return rawValue
    }
}


// This struct was originally Unit<T> during lecture video
struct UnitValue<T: UnitsConvertible>: Equatable {
    let value: Double
    let units: T
    
    func convertTo(newUnits: T) -> UnitValue<T> {
        let newValue = units.convertTo(value, toUnits: newUnits)
        return UnitValue<T>(value: newValue, units: newUnits)
    }
}

func ==<T>(lhs: UnitValue<T>, rhs: UnitValue<T>) -> Bool {
    return lhs.value == rhs.value && lhs.units.factor == rhs.units.factor
}

func +<T>(lhs: UnitValue<T>, rhs: UnitValue<T>) -> UnitValue<T> {
    let newValue = lhs.value + rhs.units.convertTo(rhs.value, toUnits: lhs.units)
    
    return UnitValue<T>(value: newValue, units: lhs.units)
}

func -<T>(lhs: UnitValue<T>, rhs: UnitValue<T>) -> UnitValue<T> {
    let newValue = lhs.value - rhs.units.convertTo(rhs.value, toUnits: lhs.units)
    
    return UnitValue<T>(value: newValue, units: lhs.units)
}

let feet = UnitValue(value: 10, units: Length.Feet)
let cms = UnitValue(value: 300, units: Length.Meters(.Centi))

let newUnit = feet + cms
print(newUnit)

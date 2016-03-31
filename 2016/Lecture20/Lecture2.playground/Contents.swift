//: Playground - noun: a place where people can play

import Foundation

protocol UnitsConvertible {
    var factor: Double { get }
}

extension UnitsConvertible {
    func convertTo(value: Double, toUnit: Self) -> Double {
        return value * self.factor / toUnit.factor
    }
    
    func convertFrom(value: Double, fromUnit: Self) -> Double {
        return fromUnit.convertTo(value, toUnit: self)
    }
}

// Power of 10's
enum MetricPrefix: Int {
    case Nano = -9
    case Micro = -6
    case Milli = -3
    case Centi = -2
    case None = 0
    case Kilo = 3
    case Mega = 6
    case Giga = 9
    case Tera = 12
}

enum Length: UnitsConvertible {
    case Meters(MetricPrefix)
    
    case Feet
    case Inches
    case Yards
    case Miles
    
    var factor: Double {
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
        switch self {
        case let .Grams(prefix):
            return pow(10, Double(prefix.rawValue - 3))
        case Ounces:
            return 0.028349523125
        case Pounds:
            return 0.45359237
        case Stones:
            return 6.35029318
        case Tons:
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

struct UnitValue<T: UnitsConvertible>: Equatable {
    let value: Double
    let unit: T
    
    func convertTo(units: T) -> UnitValue<T> {
        let convertedValue = units.convertFrom(value, fromUnit: unit)
        
        return UnitValue(convertedValue, units)
    }
    
    // Convenient constructor without labels
    init(_ value: Double, _ unit: T) {
        self.value = value
        self.unit = unit
    }
}

func ==<T>(lhs: UnitValue<T>, rhs: UnitValue<T>) -> Bool {
    return lhs.value == rhs.value && lhs.unit.factor == rhs.unit.factor
}

func +<T>(lhs: UnitValue<T>, rhs: UnitValue<T>) -> UnitValue<T> {
    let newValue = lhs.value + rhs.convertTo(lhs.unit).value
    return UnitValue<T>(newValue, lhs.unit)
}

func -<T>(lhs: UnitValue<T>, rhs: UnitValue<T>) -> UnitValue<T> {
    let newValue = lhs.value - rhs.convertTo(lhs.unit).value
    return UnitValue<T>(newValue, lhs.unit)
}

func *<T>(lhs: UnitValue<T>, scale: Double) -> UnitValue<T> {
    return UnitValue<T>(lhs.value * scale, lhs.unit)
}


let baseValue = UnitValue<Length>(10, .Meters(.None)) * 2
let newValue = baseValue

print(newValue)

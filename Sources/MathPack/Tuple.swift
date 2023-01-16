//
//  Tuple.swift
//  InScene
//
//  Created by Jeffrey Porter on 12/4/22.
//

import Foundation


/// A class for creating points, vectors, and colors.
public struct Tuple: Equatable {
    private static let epsilon = 0.00001

    public let x: Double
    public let y: Double
    public let z: Double
    public let w: Double
    public let a: Double?

    public var isPoint: Bool {
        return abs(w - 1.0) < 0.001
    }

    public var isVector: Bool {
        return abs(w) < 0.001
    }

    public var isColor: Bool {
        return a != nil
    }

    public var magnitude: Double {
        sqrt(x*x + y*y + z*z + w*w)
    }

    public var red: Double {
        guard isColor else { fatalError("Not a color") }

        return x
    }

    public var green: Double {
        return y
    }

    public var blue: Double {
        return z
    }

    public var alpha: Double {
        guard let a else { fatalError("Not a color") }
        return a
    }

    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
        self.a = nil
    }

    public init(_ x: Double, _ y: Double, _ z: Double, a: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = 1.0
        self.a = a
    }

    public static func zero() -> Tuple {
        Vector(0, 0, 0)
    }

    /// Return an origin point of [0, 0, 0]
    public static func origin() -> Tuple {
        Point(0, 0, 0)
    }

    public func normalized() -> Tuple {
        self / self.magnitude
    }

    public func dot(_ rhs: Tuple) -> Double {
        self.x*rhs.x + self.y*rhs.y + self.z*rhs.z + self.w*rhs.w
    }

    public func cross(_ rhs: Tuple) -> Tuple {
        Vector(self.y * rhs.z - self.z * rhs.y,
               self.z * rhs.x - self.x * rhs.z,
               self.x * rhs.y - self.y * rhs.x)
    }

    public func reflect(_ n: Tuple) -> Tuple {
        self - n * 2 * self.dot(n)
    }

    public func colorString() -> String {
        let red = max(min(Int(round(self.red * 255)), 255), 0)
        let green = max(min(Int(round(self.green * 255)), 255), 0)
        let blue = max(min(Int(round(self.blue * 255)), 255), 0)

        return "\(red) \(green) \(blue)"
    }

    public static func !=(lhs: Tuple, rhs: Tuple) -> Bool {
        return !(lhs == rhs)
    }

    public static func ==(lhs: Tuple, rhs: Tuple) -> Bool {
        if lhs.isColor && rhs.isColor {
            return abs(lhs.x - rhs.x) < epsilon &&
            abs(lhs.y - rhs.y) < epsilon &&
            abs(lhs.z - rhs.z) < epsilon &&
            abs(lhs.alpha - rhs.alpha) < epsilon
        } else {
            return abs(lhs.x - rhs.x) < epsilon &&
                abs(lhs.y - rhs.y) < epsilon &&
                abs(lhs.z - rhs.z) < epsilon &&
                abs(lhs.w - rhs.w) < epsilon
        }
    }

    public static prefix func -(lhs: Tuple) -> Tuple {
        Tuple(-lhs.x, -lhs.y, -lhs.z, -lhs.w)
    }

    public static func +(lhs: Tuple, rhs: Tuple) -> Tuple {
        if lhs.isColor && rhs.isColor {
            return Tuple(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, a: (lhs.alpha + rhs.alpha) / 2.0)
        } else {
            return Tuple(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
        }
    }

    public static func -(lhs: Tuple, rhs: Tuple) -> Tuple {
        if lhs.isColor && rhs.isColor {
            return Tuple(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, a: (lhs.alpha + rhs.alpha)/2.0)
        } else {
            return Tuple(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
        }
    }

    public static func *(lhs: Double, rhs: Tuple) -> Tuple {
        if rhs.isColor {
            return Tuple(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, a: rhs.alpha)
        } else {
            return Tuple(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
        }
    }

    public static func *(lhs: Tuple, rhs: Double) -> Tuple {
        if lhs.isColor {
            return Tuple(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, a: lhs.alpha)
        } else {
            return Tuple(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
        }
    }

    public static func *(lhs: Tuple, rhs: Tuple) -> Tuple {
        if lhs.isColor && rhs.isColor {
            return Tuple(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.alpha * rhs.alpha)
        } else {
            return Tuple(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w)
        }
    }

    public static func /(lhs: Tuple, rhs: Double) -> Tuple {
        Tuple(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }
}

/// Cretes a Point tuple, with w = 1.0.
/// - Parameters:
///   - x: x component
///   - y: y component
///   - z: z component
/// - Returns: a tuple representing `[x, y, z, 1.0]`
public func Point(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
    Tuple(x, y, z, 1.0)
}

/// Creates a Vector tuple, with w = 0.0.
/// - Parameters:
///   - x: x component
///   - y: y component
///   - z: z component
/// - Returns: a tuple representing `[x, y, z, 0.0]`
public func Vector(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
    Tuple(x, y, z, 0.0)
}

/// Creates a Color tuple
/// - Parameters:
///   - r: Red value in [0...1]
///   - g: Green value in [0...1]
///   - b: Blue value in [0...1]
/// - Returns: an RGB color with alpha of 1.0
public func Color(_ r: Double, _ g: Double, _ b: Double) -> Tuple {
    Tuple(r, g, b, a: 1.0)
}

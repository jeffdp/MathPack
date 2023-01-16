//
//  TupleTests.swift
//  InSceneTests
//
//  Created by Jeffrey Porter on 12/4/22.
//

import XCTest
@testable import MathPack

final class TupleTests: XCTestCase {
    func testATupleIsAPoint() {
        let a = Tuple(4.3, -4.2, 3.1, 1.0)
        XCTAssertEqual(a.x, 4.3, accuracy: CGFLOAT_EPSILON)
        XCTAssertEqual(a.y, -4.2, accuracy: CGFLOAT_EPSILON)
        XCTAssertEqual(a.z, 3.1, accuracy: CGFLOAT_EPSILON)
        XCTAssertEqual(a.w, 1.0, accuracy: CGFLOAT_EPSILON)
        XCTAssertTrue(a.isPoint)
        XCTAssertFalse(a.isVector)
    }

    func testATupleIsAVector() {
        let a = Tuple(4.3, -4.2, 3.1, 0.0)
        XCTAssertEqual(a.x, 4.3, accuracy: CGFLOAT_EPSILON)
        XCTAssertEqual(a.y, -4.2, accuracy: CGFLOAT_EPSILON)
        XCTAssertEqual(a.z, 3.1, accuracy: CGFLOAT_EPSILON)
        XCTAssertEqual(a.w, 0.0, accuracy: CGFLOAT_EPSILON)
        XCTAssertFalse(a.isPoint)
        XCTAssertTrue(a.isVector)
    }

    func testPoint() {
        let p = Point(4.0, -4.0, 3.0)
        XCTAssertTrue(p.isPoint)
    }

    func testVector() {
        let v = Vector(4.0, -4.0, 3.0)
        XCTAssertTrue(v.isVector)
    }

    func testAddTwoTuples() {
        let a1 = Tuple(3, -2, 5, 1)
        let a2 = Tuple(-2, 3, 1, 0)
        XCTAssertEqual(a1 + a2, Tuple(1, 1, 6, 1))
    }

    func testSubtractingTwoPoints() {
        let p1 = Point(3, 2, 1)
        let p2 = Point(5, 6, 7)
        XCTAssertEqual(p1 - p2, Vector(-2, -4, -6))
    }

    func testSubtractingAVectorFromAPoint() {
        let p = Point(3, 2, 1)
        let v = Vector(5, 6, 7)
        XCTAssertEqual(p - v, Point(-2, -4, -6))
    }

    func testSubtractingTwoVectors() {
        let v1 = Vector(3, 2, 1)
        let v2 = Vector(5, 6, 7)
        XCTAssertEqual(v1 - v2, Vector(-2, -4, -6))
    }

    func testSubtractingAVectorFromTheZeroVector() {
        let zero = Vector(0, 0, 0)
        let v = Vector(1, -2, 3)
        XCTAssertEqual(zero - v, Vector(-1, 2, -3))
    }

    func testNegatingATuple() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(-a, Tuple(-1, 2, -3, 4))
    }

    func testMultiplyingATupleByAScalar() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(a * 3.5, Tuple(3.5, -7, 10.5, -14))
    }

    func testMultiplyingATupleByAFraction() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(a * 0.5, Tuple(0.5, -1, 1.5, -2))
    }

    func testDividingATupleByAScalar() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(a / 2.0, Tuple(0.5, -1, 1.5, -2))
    }

    func testComputingTheMagnitudeofVectorX() {
        let v = Vector(1, 0, 0)
        XCTAssertEqual(v.magnitude, 1)
    }

    func testComputingTheMagnitudeOfVectorY() {
        let v = Vector(0, 1, 0)
        XCTAssertEqual(v.magnitude, 1)
    }

    func testComputingTheMgnitudeOfVectorZ() {
        let v = Vector(0, 0, 1)
        XCTAssertEqual(v.magnitude, 1)
    }

    func testComputingTheMagnitudeOfVector123() {
        let v = Vector(1, 2, 3)
        XCTAssertEqual(v.magnitude, sqrt(14))
    }

    func testComputingTheMagnitudeOfVectorNeg123() {
        let v = Vector(-1, -2, -3)
        XCTAssertEqual(v.magnitude, sqrt(14))
    }

    func testNormalizingVector4() {
        let v = Vector(4, 0, 0)
        XCTAssertEqual(v.normalized(), Vector(1, 0, 0))
    }

    func testNormalizingVector123() {
        let v = Vector(1, 2, 3)
        // Vector(1/sqrt(14),   2/sqrt(14),   3/sqrt(14))
        XCTAssertEqual(v.normalized(), Vector(0.26726, 0.53452, 0.80178))
    }

    func testTheMagnitudeOfANormalizedVector() {
        let v = Vector(1, 2, 3)
        let norm = v.normalized()
        XCTAssertEqual(norm.magnitude, 1)
    }

    func testTheDotProductOfTwoTuples() {
        let a = Vector(1, 2, 3)
        let b = Vector(2, 3, 4)
        XCTAssertEqual(a.dot(b), 20)
    }

    func testTheCrossProductOfTwoVectors() {
        let a = Vector(1, 2, 3)
        let b = Vector(2, 3, 4)
        XCTAssertEqual(a.cross(b), Vector(-1, 2, -1))
        XCTAssertEqual(b.cross(a), Vector(1, -2, 1))
    }

    func testColorsRedGreenBlueTuples() {
        let c = Color(-0.5, 0.4, 1.7)
        XCTAssertEqual(c.red, -0.5)
        XCTAssertEqual(c.green, 0.4)
        XCTAssertEqual(c.blue, 1.7)
    }

    func testAddingColors() {
        let c1 = Color(0.9, 0.6, 0.75)
        let c2 = Color(0.7, 0.1, 0.25)
        XCTAssertEqual(c1 + c2, Color(1.6, 0.7, 1.0))
    }

    func testSubtractingColors() {
        let c1 = Color(0.9, 0.6, 0.75)
        let c2 = Color(0.7, 0.1, 0.25)
        XCTAssertEqual(c1 - c2, Color(0.2, 0.5, 0.5))
    }

    func testMultiplyingAColorByAScalar() {
        let c = Color(0.2, 0.3, 0.4)
        XCTAssertEqual(c * 2, Color(0.4, 0.6, 0.8))
    }

    func testMultiplyingColors() {
        let c1 = Color(1, 0.2, 0.4)
        let c2 = Color(0.9, 1, 0.1)
        XCTAssertEqual(c1 * c2, Color(0.9, 0.2, 0.04))
    }

    func testReflectingAVectorApproachingAt45() {
        let v = Vector(1, -1, 0)
        let n = Vector(0, 1, 0)
        let r = v.reflect(n)
        XCTAssertEqual(r, Vector(1, 1, 0))
    }

    func testReflectingAVectorOffASlantedSurface() {
        let v = Vector(0, -1, 0)
        let n = Vector(sqrt(2)/2, sqrt(2)/2, 0)
        let r = v.reflect(n)
        XCTAssertEqual(r, Vector(1, 0, 0))
    }
}

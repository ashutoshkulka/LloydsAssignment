//
//  KittenDataTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import XCTest
@testable import LloydsAssignment


class KittenDataTests: XCTestCase {
    
    func testKittenDataEquality() {
        let kitten1 = KittenData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertEqual(kitten1.name, kitten2.name)
    }
    
    func testKittenDataInequality() {
        let kitten1 = KittenData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenData(name: "Whiskers", description: "Another cute kitten", imageUrl: "https://example.com/whiskers.jpg")
        XCTAssertNotEqual(kitten1, kitten2, "KittenData instances with different properties should not be equal")
    }
    
    func testKittenDataOtherID() {
        let kitten = KittenData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertNotNil(kitten.otherID, "otherID should not be nil")
        XCTAssertTrue(kitten.otherID.hasPrefix("other"), "otherID should have the correct prefix")
    }
}

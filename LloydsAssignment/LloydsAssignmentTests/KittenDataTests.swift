//
//  KittenDomainModelTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import XCTest
@testable import LloydsAssignment


class KittenDomainModelTests: XCTestCase {
    
    func testKittenDomainModelEquality() {
        let kitten1 = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertEqual(kitten1.name, kitten2.name)
    }
    
    func testKittenDomainModelInequality() {
        let kitten1 = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenDomainObject(name: "Whiskers", description: "Another cute kitten", imageUrl: "https://example.com/whiskers.jpg")
        XCTAssertNotEqual(kitten1, kitten2, "KittenDomainModel instances with different properties should not be equal")
    }
    
    func testKittenDomainModelOtherID() {
        let kitten = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertNotNil(kitten.otherID, "otherID should not be nil")
        XCTAssertTrue(kitten.otherID.hasPrefix("other"), "otherID should have the correct prefix")
    }
}

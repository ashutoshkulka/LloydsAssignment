//
//  KittenDomainDataTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import XCTest
@testable import LloydsAssignment


class KittenDomainDataTests: XCTestCase {
    
    func testKittenDomainDataEquality() {
        let kitten1 = KittenDomainData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenDomainData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertEqual(kitten1.name, kitten2.name)
    }
    
    func testKittenDomainDataInequality() {
        let kitten1 = KittenDomainData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenDomainData(name: "Whiskers", description: "Another cute kitten", imageUrl: "https://example.com/whiskers.jpg")
        XCTAssertNotEqual(kitten1, kitten2, "KittenDomainData instances with different properties should not be equal")
    }
    
    func testKittenDomainDataOtherID() {
        let kitten = KittenDomainData(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertNotNil(kitten.otherID, "otherID should not be nil")
        XCTAssertTrue(kitten.otherID.hasPrefix("other"), "otherID should have the correct prefix")
    }
}

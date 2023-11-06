//
//  KittenDomainModelTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import XCTest
@testable import LloydsAssignment


class KittenDomainModelTests: XCTestCase {
    
    func testKittenDomainObjectEquality() {
        let kitten1 = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertEqual(kitten1.name, kitten2.name)
    }
    
    func testKittenDomainObjectInequality() {
        let kitten1 = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        let kitten2 = KittenDomainObject(name: "Whiskers", description: "Another cute kitten", imageUrl: "https://example.com/whiskers.jpg")
        XCTAssertNotEqual(kitten1, kitten2, "KittenDomainModel instances with different properties should not be equal")
    }
    
    func testKittenDomainObjectOtherID() {
        let kitten = KittenDomainObject(name: "Fluffy", description: "A cute kitten", imageUrl: "https://example.com/fluffy.jpg")
        XCTAssertNotNil(kitten.otherID, "otherID should not be nil")
        XCTAssertTrue(kitten.otherID.hasPrefix("other"), "otherID should have the correct prefix")
    }
    
    func testKittenDomainModelEquality() {
        // Given
        let kitten1 = KittenDomainObject(name: "Fluffy", description: "Adorable kitten", imageUrl: "fluffy.jpg")
        let kitten2 = KittenDomainObject(name: "Fluffy", description: "Adorable kitten", imageUrl: "fluffy.jpg")
        let kittenDomainModel1 = KittenDomainModel(kittenDomainObjects: [kitten1])
        let kittenDomainModel2 = KittenDomainModel(kittenDomainObjects: [kitten2])
        
        // Then
        XCTAssertEqual(kittenDomainModel1.kittenDomainObjects.first?.name, kittenDomainModel2.kittenDomainObjects.first?.name, "KittenDomainModels should be equal")
    }
    
    func testKittenDomainModelInequality() {
        // Given
        let kitten1 = KittenDomainObject(name: "Fluffy", description: "Adorable kitten", imageUrl: "fluffy.jpg")
        let kitten2 = KittenDomainObject(name: "Whiskers", description: "Cute kitten", imageUrl: "whiskers.jpg")
        let kittenDomainModel1 = KittenDomainModel(kittenDomainObjects: [kitten1])
        let kittenDomainModel2 = KittenDomainModel(kittenDomainObjects: [kitten2])
        
        // Then
        XCTAssertNotEqual(kittenDomainModel1, kittenDomainModel2, "KittenDomainModels should not be equal")
    }
}

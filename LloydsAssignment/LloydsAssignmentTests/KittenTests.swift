//
//  KittenTests.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import XCTest
@testable import LloydsAssignment

class KittenTests: XCTestCase {
    
    func testKittenEquality() {
        let kitten1 = Kitten(title: "Kitty 1", description: "Adorable kitten", url: "https://example.com/kitty1.jpg")
        let kitten2 = Kitten(title: "Kitty 1", description: "Adorable kitten", url: "https://example.com/kitty1.jpg")
        let kitten3 = Kitten(title: "Kitty 2", description: "Another cute kitten", url: "https://example.com/kitty2.jpg")
        
        XCTAssertEqual(kitten1, kitten2, "Kittens with the same properties should be equal")
        XCTAssertNotEqual(kitten1, kitten3, "Kittens with different properties should not be equal")
    }
}

class KittenResponseTests: XCTestCase {
    
    func testKittenResponseDecoding() throws {
        let json = """
        {
            "status": "OK",
            "code": 200,
            "total": 2,
            "data": [
                {"title": "Kitty 1", "description": "Adorable kitten", "url": "https://example.com/kitty1.jpg"},
                {"title": "Kitty 2", "description": "Cute kitten", "url": "https://example.com/kitty2.jpg"}
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(KittenResponse.self, from: json)
        
        XCTAssertEqual(response.status, "OK")
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.total, 2)
        
        XCTAssertEqual(response.data.count, 2)
        XCTAssertEqual(response.data[0].title, "Kitty 1")
        XCTAssertEqual(response.data[1].description, "Cute kitten")
        XCTAssertEqual(response.data[1].url, "https://example.com/kitty2.jpg")
    }
}

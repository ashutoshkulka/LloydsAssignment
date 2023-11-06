//
//  KittenResponseToDomainDataListMapperTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 06/11/23.
//

import Foundation
import XCTest
import Combine
@testable import LloydsAssignment


class KittenResponseToDomainDataListMapperTests: XCTestCase {
    
    func testMapping() {
        // Arrange
        let mapper = KittenResponseToDomainDataListMapper()
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
        let kittenResponse = try! decoder.decode(KittenResponse.self, from: json)

        // Act
        let domainDataList = mapper.mapToDomainDataList(response: kittenResponse)
        
        // Assert
        XCTAssertEqual(domainDataList.kittenDomainData.count, 2)
        XCTAssertEqual(domainDataList.kittenDomainData[0].name, "Kitty 1")
        XCTAssertEqual(domainDataList.kittenDomainData[0].description, "Adorable kitten")
        XCTAssertEqual(domainDataList.kittenDomainData[0].imageUrl, "https://example.com/kitty1.jpg")
        XCTAssertEqual(domainDataList.kittenDomainData[1].name, "Kitty 2")
        XCTAssertEqual(domainDataList.kittenDomainData[1].description, "Cute kitten")
        XCTAssertEqual(domainDataList.kittenDomainData[1].imageUrl, "https://example.com/kitty2.jpg")
    }
}

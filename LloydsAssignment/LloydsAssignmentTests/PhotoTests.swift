//
//  PhotoTests.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import XCTest
@testable import LloydsAssignment

class PhotoTests: XCTestCase {

    func testPhotoDecoding() throws {
        // Given
        let json = """
        {
            "albumId": 1,
            "id": 1,
            "title": "sample title",
            "url": "https://example.com/photo.jpg",
            "thumbnailUrl": "https://example.com/thumbnail.jpg"
        }
        """.data(using: .utf8)!
        
        // When
        let decoder = JSONDecoder()
        let photo = try decoder.decode(Photo.self, from: json)
        
        // Then
        XCTAssertEqual(photo.albumId, 1)
        XCTAssertEqual(photo.id, 1)
        XCTAssertEqual(photo.title, "sample title")
        XCTAssertEqual(photo.url, "https://example.com/photo.jpg")
        XCTAssertEqual(photo.thumbnailUrl, "https://example.com/thumbnail.jpg")
    }
    
    func testPhotoEncoding() throws {
        // Given
        let photo = Photo(albumId: 1, id: 1, title: "sample title", url: "https://example.com/photo.jpg", thumbnailUrl: "https://example.com/thumbnail.jpg")
        
        // When
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(photo)
        
        // Then
        let decoder = JSONDecoder()
        let decodedPhoto = try decoder.decode(Photo.self, from: encodedData)
        XCTAssertEqual(photo, decodedPhoto)
    }
}

//
//  PhotoModelTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni.
//

import XCTest
@testable import LloydsAssignment // Import your app module

class PhotoModelTests: XCTestCase {

    func testPhotoModelInitialization() {
        // Given
        let photo = Photo(albumId: 1, id: 1, title: "Photo Title", url: "https://example.com/photo.jpg", thumbnailUrl: "https://example.com/thumbnail.jpg")
        let image = UIImage(systemName: "star")!
        // When
        let photoModel = PhotoModel(photo: photo, image: image)

        // Then
        XCTAssertEqual(photoModel.photo, photo, "Photo object should match the provided photo")
        XCTAssertEqual(photoModel.image, image, "Image object should match the provided image")
    }
}

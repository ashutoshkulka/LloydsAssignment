//
//  HomeViewModelTests.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import XCTest
@testable import LloydsAssignment

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testFetchAndDownloadPhotos() {
        // Given
        let expectation = self.expectation(description: "Photos fetched and downloaded successfully")
        
        // When
        viewModel.fetchAndDownloadPhotos()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Waiting for 5 seconds for the API call to complete (adjust timeout as needed)
            XCTAssertTrue(self.viewModel.photos.count > 0, "Photos should be downloaded and stored")
            XCTAssertFalse(self.viewModel.isLoading, "Loading state should be false after fetching and downloading")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil) // Waiting for the expectation to be fulfilled within 10 seconds (adjust timeout as needed)
    }
    
    // Add more test cases as needed for different scenarios (e.g., error cases)
}

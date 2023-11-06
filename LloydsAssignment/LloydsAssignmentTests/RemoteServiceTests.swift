//
//  RemoteServiceTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 06/11/23.
//

import Foundation
import XCTest
@testable import LloydsAssignment

class RemoteServiceTests: XCTestCase {

    class MockService: ServiceProtocol {
        var shouldSucceed: Bool = true
        
        func fetchAllKittens(completion: @escaping ServiceProtocol.FetchCompletion) {
            if shouldSucceed {
                let mockResponse = KittenResponse(status: "success", code: 200, total: 2, data: [
                    Kitten(title: "Fluffy", description: "Adorable kitten", url: "fluffy.jpg"),
                    Kitten(title: "Whiskers", description: "Cute kitten", url: "whiskers.jpg")
                ])
                completion(.success(mockResponse))
            } else {
                let error = NSError(domain: "MockErrorDomain", code: 500, userInfo: nil)
                completion(.failure(error))
            }
        }
    }
    
    func testFetchAllKittensSuccess() {
        // Given
        let mockService = MockService()
        let expectation = self.expectation(description: "Fetch Kittens Successfully")
        // When
        mockService.fetchAllKittens { result in
            switch result {
            case .success(let kittenResponse):
                // Then
                XCTAssertNotNil(kittenResponse)
                // Add assertions for the expected kitten response data
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil) // Adjust timeout if necessary
    }

    func testFetchAllKittensFailure() {
        // Given
        let mockService = MockService()
        mockService.shouldSucceed = false
        let expectation = self.expectation(description: "Fetch Kittens Failure")
        // When
        mockService.fetchAllKittens { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                // Add assertions for the expected error type or description
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil) // Adjust timeout if necessary
    }
}

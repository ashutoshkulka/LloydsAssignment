//
//  HomeViewModelTests.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import XCTest
import Combine
@testable import LloydsAssignment


class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        viewModel = HomeViewModel(service: mockService)
    }
    
    func testFetchKittensSuccess() {
        // Arrange
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
        let response = try! decoder.decode(KittenResponse.self, from: json)
        mockService.fetchKittensResult = .success(response)
        
        // Act
        viewModel.fetchAllKittens()
        
        // Assert
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        
        // Wait for an expectation to be fulfilled, timeout after a certain interval
        let expectation = XCTestExpectation(description: "Fetch kittens expectation")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Additional assertions can be made here if needed
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.kittens)
            XCTAssertEqual(self.viewModel.kittens?.first?.title, "Kitty 1")
            XCTAssertEqual(self.viewModel.kittens?.first?.description, "Adorable kitten")
            XCTAssertEqual(self.viewModel.kittens?.first?.url, "https://example.com/kitty1.jpg")
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled within a specific timeout
        wait(for: [expectation], timeout: 5) // Adjust the timeout value as needed
    }
    
    func testFetchKittensFailure() {
        
        // Arrange
        mockService.fetchKittensResult = .failure(.badURL)
        // Act
        viewModel.fetchAllKittens()
        
        // Assert
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertNil(viewModel.kittens)
        
        // Wait for an expectation to be fulfilled, timeout after a certain interval
        let expectation = XCTestExpectation(description: "Fetch kittens expectation")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Additional assertions can be made here if needed
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.errorMessage)
            
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled within a specific timeout
        wait(for: [expectation], timeout: 5) // Adjust the timeout value as needed
    }
}

class MockAPIService: APIServiceProtocol {
    var fetchKittensResult: Result<KittenResponse, APIError>? = nil
    
    func fetchKittens<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        switch fetchKittensResult {
        case .success(let kittens as T):
            completion(.success(kittens))
        case .failure(let error):
            completion(.failure(error))
        default:
            fatalError("Invalid fetchKittensResult type")
        }
        
    }
}

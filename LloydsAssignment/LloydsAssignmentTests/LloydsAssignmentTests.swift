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
    var mockFetchKittensUseCase: MockFetchKittensUseCase!
    
    override func setUpWithError() throws {
        super.setUp()
        mockFetchKittensUseCase = MockFetchKittensUseCase()
        viewModel = HomeViewModel(fetchKittensUseCase: mockFetchKittensUseCase)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockFetchKittensUseCase = nil
        super.tearDown()
    }
    
    func testFetchKittensSuccess() {
        
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
        
        mockFetchKittensUseCase.result = .success(response)
        
        // Act
        viewModel.fetchAllKittens()
        // Wait for an expectation to be fulfilled, timeout after a certain interval
        let expectation = XCTestExpectation(description: "Fetch kittens expectation")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            
            // Assert
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.kittens)
            XCTAssertEqual(self.viewModel.kittens?.first?.title, "Kitty 1")
            XCTAssertEqual(self.viewModel.kittens?.first?.description, "Adorable kitten")
            XCTAssertEqual(self.viewModel.kittens?.first?.url, "https://example.com/kitty1.jpg")
            
            XCTAssertNil(self.viewModel.errorMessage)
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled within a specific timeout
        wait(for: [expectation], timeout: 5) // Adjust the timeout value as needed
        
    }
    
    func testFetchKittensFailure() {
        // Arrange
        mockFetchKittensUseCase.result = .failure(.badURL)
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


class MockFetchKittensUseCase: FetchKittensUseCase {
    var result: FetchKittensUseCase.Result = .failure(APIError.unknown)
    
    func execute<T>(_ type: T.Type, url: URL?, completion: @escaping (FetchKittensUseCase.Result) -> Void) where T: Decodable {
        completion(result)
    }
}

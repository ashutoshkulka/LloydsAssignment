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
    var mockMapper: MockKittenResponseToDomainDataListMapper!
    
    override func setUpWithError() throws {
        super.setUp()
        mockMapper = MockKittenResponseToDomainDataListMapper()
        
        mockFetchKittensUseCase = MockFetchKittensUseCase(mapper: mockMapper)
        viewModel = HomeViewModel(fetchKittensUseCase: mockFetchKittensUseCase)
        
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockFetchKittensUseCase = nil
        mockMapper = nil
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
        let domainDataList = mockMapper.mapToDomainDataList(response: response)
        
        mockFetchKittensUseCase.result = .success(domainDataList)
        
        // Act
        viewModel.fetchAllKittens()
        // Wait for an expectation to be fulfilled, timeout after a certain interval
        let expectation = XCTestExpectation(description: "Fetch kittens expectation")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            
            // Assert
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.kittenDomainDataList)
            XCTAssertEqual(self.viewModel.kittenDomainDataList?.kittenDomainData.first?.name, "Kitty 1")
            XCTAssertEqual(self.viewModel.kittenDomainDataList?.kittenDomainData.first?.description, "Adorable kitten")
            XCTAssertEqual(self.viewModel.kittenDomainDataList?.kittenDomainData.first?.imageUrl, "https://example.com/kitty1.jpg")
            
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
        XCTAssertNil(viewModel.kittenDomainDataList?.kittenDomainData)
        
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

// Mock implementation of FetchKittensUseCaseProtocol for testing
class MockFetchKittensUseCase: FetchKittensUseCaseProtocol {
    var mapper: KittensDomainDataMapperProtocol
    
    var result: HomeViewModelUseCase.ResponseDataProvider?
    
    func fetchAllKittens(url: URL?, completion: @escaping (HomeViewModelUseCase.ResponseDataProvider) -> Void) {
        if let result = result {
            completion(result)
        }
    }
    
    init(mapper: KittensDomainDataMapperProtocol) {
        self.mapper = mapper
    }
}



class MockKittenResponseToDomainDataListMapper: KittensDomainDataMapperProtocol {
    func mapToDomainDataList(response: KittenResponse) -> KittenDomainDataList {
        return KittenDomainDataList(kittenDomainData: response.data.map { kitten in
            return KittenDomainData(name: kitten.title, description: kitten.description, imageUrl: kitten.url)
        })
    }
}


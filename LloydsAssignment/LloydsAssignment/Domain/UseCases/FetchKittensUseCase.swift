//
//  FetchKittensUseCase.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import Foundation

class FetchKittensUseCase: FetchKittensUseCaseProtocol {
    /// The repository responsible for providing data fetching functionalities.
    private let repository: RepositoryProtocol
    /// Initializes the interactor with a specific repository.
    ///
    /// - Parameter repository: An object conforming to `Repository` protocol, providing data fetching functionalities.
    init(repository: Repository) {
        self.repository = repository
    }
    
    /// Fetches data of the specified type from the provided URL using the associated repository.
    ///
    /// - Parameters:
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func fetchAllKittens( completion: @escaping (ResponseDomainDataProvider) -> Void) {
        repository.fetchAllKittens() { result in
            completion(result)
        }
    }
}

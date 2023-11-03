//
//  FetchKittensUseCase.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import Foundation

class FetchKittensUseCase: FetchKittensUseCaseProtocol {
    /// The repository responsible for providing data fetching functionalities.
   private let repository: APIServiceRepositoryProtocol
    /// Initializes the interactor with a specific repository.
    ///
    /// - Parameter repository: An object conforming to `APIServiceRepositoryProtocol` protocol, providing data fetching functionalities.
    init(repository: APIServiceRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Fetches data of the specified type from the provided URL using the associated repository.
    ///
    /// - Parameters:
    ///   - type: The type to decode the fetched data into, conforming to the `Decodable` protocol.
    ///   - url: The URL from which to fetch the data.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func fetchAllKittens<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (FetchKittensUseCase.ResponseDataProvider) -> Void) {
        repository.execute(type, url: url, completion: completion)
    }
}

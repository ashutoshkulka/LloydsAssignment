//
//  FetchKittensInteractor.swift
//  FetchKittensInteractor
//
//  Created by Ashutosh Kulkarni.//

import Foundation

/// An interactor responsible for fetching data of a specific type from a given URL using a repository.
class FetchKittensInteractor: FetchKittensUseCase {
    /// The repository responsible for providing data fetching functionalities.
    let repository: KittensRepository
    /// Initializes the interactor with a specific repository.
    ///
    /// - Parameter repository: An object conforming to `KittensRepository` protocol, providing data fetching functionalities.
    init(repository: KittensRepository) {
        self.repository = repository
    }
    
    /// Fetches data of the specified type from the provided URL using the associated repository.
    ///
    /// - Parameters:
    ///   - type: The type to decode the fetched data into, conforming to the `Decodable` protocol.
    ///   - url: The URL from which to fetch the data.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func execute<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (FetchKittensUseCase.Result) -> Void) {
        repository.fetchKittens(type, url: url, completion: completion)
    }
}

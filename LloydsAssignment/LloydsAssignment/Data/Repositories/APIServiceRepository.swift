//
//  APIServiceRepository.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import Foundation

class APIServiceRepository: APIServiceRepositoryProtocol {
    
    /// The repository responsible for providing data fetching functionalities.
    let repository: APIServiceRepositoryProtocol
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
    func execute<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (ResponseDataProvider) -> Void) {
        repository.execute(type, url: url, completion: completion)
    }
}

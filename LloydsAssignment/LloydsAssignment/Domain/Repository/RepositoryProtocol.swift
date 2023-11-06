//
//  RepositoryProtocol.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import Foundation

/// A protocol defining the contract for a repository responsible for fetching kitten data from a remote source.
protocol RepositoryProtocol {
    /// The result type representing either a successfully KittenDomainModel object or an error.
    typealias ResponseDataProvider = Swift.Result<KittenDomainModel?, Error>

    /// The type representing the completion closure for fetching kittens.
    typealias FetchCompletion = (ResponseDataProvider) -> Void
    /// Fetches data of the specified type from the provided URL asynchronously.
    ///
    /// - Parameters:
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func fetchAllKittens(completion: @escaping FetchCompletion)
}

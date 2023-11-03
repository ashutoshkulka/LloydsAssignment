//
//  APIServiceRepositoryProtocol.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import Foundation

/// A protocol defining the contract for a repository responsible for fetching kitten data from a remote source.
protocol APIServiceRepositoryProtocol {
    /// The type representing the completion closure for fetching kittens.
    typealias FetchCompletion = (FetchKittensUseCase.ResponseDataProvider) -> Void
    /// Fetches data of the specified type from the provided URL asynchronously.
    ///
    /// - Parameters:
    ///   - type: The type to decode the fetched data into, conforming to the `Decodable` protocol.
    ///   - url: The URL from which to fetch the data.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func execute<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping FetchCompletion)
}

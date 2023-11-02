//
//  FetchKittensUseCase.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import Foundation

protocol FetchKittensUseCase {
    /// The result type representing either a successfully decoded object or an error.
    typealias Result = Swift.Result<Decodable, APIError>
    /// Fetches data of the specified type from the provided URL.
    ///
    /// - Parameters:
    ///   - type: The type to decode the fetched data into, conforming to the `Decodable` protocol.
    ///   - url: The URL from which to fetch the data.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func execute<T: Decodable>(_ type: T.Type, url: URL?,completion: @escaping (Result) -> Void)
}

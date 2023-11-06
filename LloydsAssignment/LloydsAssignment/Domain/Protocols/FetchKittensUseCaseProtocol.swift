//
//  FetchKittensUseCaseProtocol.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import Foundation

protocol FetchKittensUseCaseProtocol {
    /// The result type representing either a successfully decoded object or an error.
    typealias ResponseDomainDataProvider = Swift.Result<KittenDomainModel?, Error>
    /// Fetches data of the specified type from the provided URL.
    ///
    /// - Parameters:
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func fetchAllKittens(completion: @escaping (ResponseDomainDataProvider) -> Void)
}

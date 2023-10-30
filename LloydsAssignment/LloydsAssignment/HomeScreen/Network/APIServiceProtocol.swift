//
//  APIServiceProtocol.swift
//  APIServiceProtocol
//
//  Created by Ashutosh Kulkarni.//

import Foundation


protocol APIServiceProtocol {
    /// Fetches a list of kittens from the API.
    /// - Parameters:
    ///   - url: The URL to fetch the kittens from.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the array of kittens or an error.
    func fetchKittens<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) 
}

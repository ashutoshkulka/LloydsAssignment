//
//  RemoteService.swift
//  RemoteService
//
//  Created by Ashutosh Kulkarni.

import Foundation

private enum CustomError: Error {
    case invalidURL
    case networkError
}

/// A nested struct containing URL paths used for network requests.
private struct URLPath {
    /// The URL path for fetching photos from a remote server.
    static let photosURL = "https://fakerapi.it/api/v1/images?_quantity=99&_type=kittens&_height=300"
}

/// A service responsible for making API requests and handling responses.
struct RemoteService: ServiceProtocol {
    /// Fetches a list of kittens from the API.
    ///
    /// - Parameters:
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the array of kittens or an error.
    func fetchAllKittens(completion: @escaping ServiceProtocol.FetchCompletion) {
        guard let url = URL(string: URLPath.photosURL) else {
            completion(Result.failure(CustomError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let kittens = try decoder.decode(KittenResponse.self, from: data)
                    completion(ResponseDataProvider.success(kittens))
                } catch let error {
                    completion(Result.failure(error))
                }
            }
        }
        task.resume()
    }
}


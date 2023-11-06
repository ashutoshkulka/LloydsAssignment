//
//  RemoteService.swift
//  RemoteService
//
//  Created by Ashutosh Kulkarni.

import Foundation

/// A service responsible for making API requests and handling responses.
struct RemoteService: APIServiceRepositoryProtocol {
    /// Fetches a list of kittens from the API.
    ///
    /// - Parameters:
    ///   - url: The URL to fetch the kittens from.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the array of kittens or an error.
    func execute<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping APIServiceRepositoryProtocol.FetchCompletion) {
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let kittens = try decoder.decode(type, from: data)
                    completion(ResponseDataProvider.success(kittens))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}

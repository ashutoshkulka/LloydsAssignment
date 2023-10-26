//
//  NetworkAPIHandler.swift
//  Pokemon
//
//

import Foundation
import Alamofire

actor NetworkAPIHandler: GlobalActor {
    static let shared = NetworkAPIHandler()
    
    private init() {
        
    }

    func getData(url: String, parameters: Parameters? = nil) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                parameters: parameters,
                requestModifier: { $0.timeoutInterval = 10.0}
            )
            .responseData { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            var userInfo = nserror.userInfo
            userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
            let currentError = NSError(
                domain: nserror.domain,
                code: nserror.code,
                userInfo: userInfo
            )
            return currentError

        }
        return error
    }
}

//
//  APIError.swift
//  APIError
//
//  Created by Ashutosh Kulkarni.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        // user feedback
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .url(_):
            return "Something went wrong."
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(_):
            return "url session error"
        case .parsing(_):
            return "parsing error"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
}

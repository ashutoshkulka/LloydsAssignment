//
//  Kitten.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

/// A struct representing a kitten with its title, description, and URL.
struct Kitten: Codable, Equatable {
    /// The title of the kitten.
    let title: String
    /// The description of the kitten.
    let description: String
    /// The URL of the kitten image.
    let url: String
}

/// A struct representing a response containing a list of kitten data.
struct KittenResponse: Codable, Equatable {
    /// The status of the response, indicating whether it was successful or not.
    let status: String
    /// The HTTP status code of the response.
    let code: Int
    /// The total number of kitten data items in the response.
    let total: Int
    /// An array of `Kitten` objects representing individual kittens.
    let data: [Kitten]
}

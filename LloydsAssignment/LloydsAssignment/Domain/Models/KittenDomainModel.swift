//
//  KittenDomainModel.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import Foundation

struct KittenDomainModel: Equatable {
    let kittenDomainObjects: [KittenDomainObject]
}

/// Represents data for a kitten, including its name, description, and image URL.
struct KittenDomainObject: Equatable {
    let otherID = "other\(UUID())"
    /// The name of the kitten.
    let name: String
    /// The description of the kitten.
    let description: String
    /// The imageUrl of the kitten image.
    let imageUrl: String
}

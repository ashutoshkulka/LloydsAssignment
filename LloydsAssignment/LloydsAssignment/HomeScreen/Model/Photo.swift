//
//  Photo.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

struct Photo: Codable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

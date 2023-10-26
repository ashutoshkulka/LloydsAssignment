//
//  ResponseModel.swift
//  Pokemon
//
//

import Foundation

struct HTTPResponse: Decodable {
    let results: [[String: String]]
}

struct DetailResponse: Decodable {
    let name: String
}

struct AbilitiesResponse: Decodable {
    let ability: DetailResponse
}

struct TypesResponse: Decodable {
    let type: DetailResponse
}

struct StatsResponse: Decodable {
    let baseStat: Int
    let stat: DetailResponse

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct TextEntries: Decodable {
    let flavorText: String
    let language: DetailResponse

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

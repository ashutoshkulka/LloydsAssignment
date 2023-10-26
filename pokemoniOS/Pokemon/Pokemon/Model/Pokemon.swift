//
//  Pokemon.swift
//  Pokemon
//
//

import Foundation

struct Stat {
    var name: String
    var value: Int
}

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [String]
    let types: [String]
    let stats: [Stat]
    var imageURL: String
    var description: PokemonDescription?

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, imageURL, abilities, types, stats
        case sprites
        case other
        case dreamWorld = "dream_world"
        case frontDefault = "front_default"
    }

    init(id: Int, name: String, height: Int, weight: Int, gender: [String],
         abilities: [String], types: [String], imageURL: String,
         stats: [Stat] = []) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.abilities = abilities
        self.types = types
        self.imageURL = imageURL
        self.stats = stats
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.height = try container.decode(Int.self, forKey: .height)
            self.weight = try container.decode(Int.self, forKey: .weight)
            self.imageURL = try container.nestedContainer(keyedBy: CodingKeys.self,
                            forKey: .sprites).nestedContainer(keyedBy: CodingKeys.self,
                            forKey: .other).nestedContainer(keyedBy: CodingKeys.self,
                            forKey: .dreamWorld).decode(String.self, forKey: .frontDefault)
            self.abilities = try container.decode([AbilitiesResponse].self, forKey: CodingKeys.abilities)
                                                 .map {$0.ability.name}
            self.types = try container.decode([TypesResponse].self, forKey: .types).map {$0.type.name}
            self.stats = try container.decode([StatsResponse].self, forKey: CodingKeys.stats)
                .sorted(by: { $0.stat.name < $1.stat.name})
                .map({ response in
                return Stat(name: response.stat.name, value: response.baseStat)
            })

        } catch {
            throw error
        }
    }
}

extension Pokemon {
    static let preview = Pokemon(id: 1, name: "bulbasaur", height: 7,
                                 weight: 69, gender: ["male", "female"],
                                 abilities: ["overgrow", "chlorophyll"],
                                 types: ["grass", "poison"],
                                 imageURL: "https://test.svg")
}

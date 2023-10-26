//
//  PokemonDescription.swift
//  Pokemon
//
//

import Foundation

struct PokemonDescription: Decodable {
    let id: Int
    let eggGroups: [String]
    let description: String
    var evolutionChain: EvolutionChain?
    var genders: [String] = []

    enum CodingKeys: String, CodingKey {
        case id
        case eggGroups = "egg_groups"
        case description = "flavor_text_entries"
        case genders = "gender_rate"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.eggGroups = try container.decode([DetailResponse].self,
                            forKey: .eggGroups).map {$0.name}
        self.description = try container.decode([TextEntries].self, forKey: .description)
                            .filter { $0.language.name == "en"}
                            .map {$0.flavorText}
            .removeDuplicates()
            .reduce(.empty) {$0 + $1}
        let genderRate = try container.decode(Int.self, forKey: .genders)
        self.genders = getGender(genderRate: genderRate)
    }

    init(id: Int, eggGroups: [String], description: String, genders: [String]) {
        self.id = id
        self.eggGroups = eggGroups
        self.description = description
        self.genders = genders
    }

    private func getGender(genderRate: Int) -> [String] {

        let maleArray = [1, 2, 4, 6, 7]
        let femaleArray = [1, 2, 4, 6, 7, 8]
        let genderLess = -1

        let maleString = maleArray.contains(genderRate) ? "male" : .empty
        let femaleString = femaleArray.contains(genderRate) ? "female" : .empty
        let genderlessString = (genderRate == genderLess) ? "genderless" : .empty

        var genderArray: [String] = []

        if !maleString.isEmpty {
            genderArray.append(maleString)
        }

        if !femaleString.isEmpty {
            genderArray.append(femaleString)
        }

        if !genderlessString.isEmpty {
            genderArray.append(genderlessString)
        }
        return genderArray
    }
}

extension PokemonDescription {
    static let preview = PokemonDescription(id: 1,
                                                eggGroups: ["monster", "dragon"],
                                                description: "Test description",
                                                genders: ["male", "female"])
}

struct WeakAgainst: Decodable {
    var natures: [String] = []

    enum CodingKeys: String, CodingKey {
        case natures
        case damageRelation = "damage_relations"
        case doubleDamageFrom = "double_damage_from"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.natures = try container.nestedContainer(keyedBy: CodingKeys.self,
                        forKey: .damageRelation).decode([DetailResponse].self,
                        forKey: .doubleDamageFrom).map {$0.name}
    }

    init(natures: [String]) {
        self.natures = natures
    }
}

extension WeakAgainst {
    static let preview = WeakAgainst(natures: ["Ground", "Rock", "Water"])
}

struct EvolutionChain: Decodable {
    var species: DetailResponse
    var evolvesTo: [EvolutionTo]

    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
        case chain = "chain"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let childContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .chain)
        self.species = try childContainer.decode(DetailResponse.self, forKey: .species)
        self.evolvesTo = try childContainer.decode([EvolutionTo].self, forKey: .evolvesTo)
    }

    init(species: DetailResponse, evolutionTo: [EvolutionTo]) {
        self.species = species
        self.evolvesTo = evolutionTo
    }
}

struct EvolutionTo: Decodable {
    var species: DetailResponse
    var evolvesTo: [EvolutionTo]

    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }

    init(species: DetailResponse, evolutionTo: [EvolutionTo]) {
        self.species = species
        self.evolvesTo = evolutionTo
    }
}

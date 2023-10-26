//
//  Constants.swift
//  Pokemon
//
//

import Foundation
import SwiftUI

enum URLs {
    case pokemonList
    case pokemonDetails
    case pokemonDescription
    case pokemonWeakness
    case pokemonEvolutionChain
    case pokemonTypeList
    case pokemonGenderList

    var url: String {
        switch self {
        case .pokemonList: return "https://pokeapi.co/api/v2/pokemon?offset=0&limit=500"
        case .pokemonDetails: return "https://pokeapi.co/api/v2/pokemon/"
        case .pokemonDescription: return "https://pokeapi.co/api/v2/pokemon-species/"
        case .pokemonWeakness: return "https://pokeapi.co/api/v2/type/"
        case .pokemonEvolutionChain: return "https://pokeapi.co/api/v2/evolution-chain/"
        case .pokemonTypeList: return "https://pokeapi.co/api/v2/type/"
        case .pokemonGenderList: return "https://pokeapi.co/api/v2/gender/"
        }
    }
}

struct Title {
    static let gender = "Gender"
    static let type = "Type"
    static let stats = "Stats"
    static let filters = "Filters"
    static let types = "Types"
    static let weakAgainst = "Weak Against"
    static let height = "Height"
    static let weight = "Weight"
    static let genders = "Gender(s)"
    static let eggGroups = "Egg Groups"
    static let abilities = "Abilities"
    static let reset = "Reset"
    static let apply = "Apply"
    static let evolutionChain = "Evolution Chain"
    static let pokedex = "Pokédex"
    static let homeDescription = "Search for any Pokémon that exists on the planet"
}

struct Constants {
    static let readMore = "read more"
    static let loading = "Loading..."
    static let xImage = "X"
    static let fetchingEvolutionList = "Fetching Evolution List..."
    static let zero = "000"
    static let commaeSeprator = ", "
    static let fetchingData = "Fetching data, please wait..."
    static let searchFieldPlaceholder = "Name or Number"
}

//
//  MockNetworkAPI.swift
//  PokemonTests
//
//

import Foundation
@testable import PokemoniOS
import SVGKit

class MockNetworkAPI: NetworkHandlerInterface {
    func fetchPokemonList() async -> HTTPResponse {
       return Bundle.main.decode(HTTPResponse.self,
                                          from: "PokemonList")
    }

    func fetchPokemonDetails(url: String) async -> Pokemon? {
        return Bundle.main.decode(Pokemon.self,
                                           from: "PokemonDetails")
    }

    func fetchPokemonDescription(id: Int) async -> PokemonDescription? {
        return Bundle.main.decode(PokemonDescription.self,
                                           from: "PokemonSpecies")
    }

    func fetchPokemonWeakAgainst(type: String) async -> WeakAgainst? {
        return Bundle.main.decode(WeakAgainst.self,
                                           from: "PokemonDamage")
    }

    func fetchPokemonEvolutionChain(id: Int) async -> EvolutionChain? {
        return Bundle.main.decode(EvolutionChain.self,
                                           from: "PokemonEvolutionChain")
    }

    func fetchPokemonTypeList() async -> HTTPResponse? {
        return Bundle.main.decode(HTTPResponse.self,
                                           from: "PokemonTypes")
    }

    func fetchGenderList() async -> HTTPResponse? {
        return Bundle.main.decode(HTTPResponse.self,
                                           from: "PokemonGenderList")
    }

    func fetchPokemonDetailsBy(name: String) async -> Pokemon? {
        return Bundle.main.decode(Pokemon.self,
                                           from: "PokemonDetails")
    }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type,
                              from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

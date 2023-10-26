//
//  NetworkAPI.swift
//  Pokemon
//
//

import Foundation


class NetworkAPI: NetworkHandlerInterface {
    func fetchPokemonList() async -> HTTPResponse {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonList.url)
            return try JSONDecoder().decode(HTTPResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return HTTPResponse(results: [[:]])
    }

    func fetchPokemonDetails(url: String) async -> Pokemon? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: url)
            return try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    func fetchPokemonDetailsBy(name: String) async -> Pokemon? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonDetails.url + "\(name)")
            return try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func fetchPokemonDescription(id: Int) async -> PokemonDescription? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonDescription.url + "\(id)")
            return try JSONDecoder().decode(PokemonDescription.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func fetchPokemonWeakAgainst(type: String) async -> WeakAgainst? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonWeakness.url + "\(type)")
            return try JSONDecoder().decode(WeakAgainst.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func fetchPokemonEvolutionChain(id: Int) async -> EvolutionChain? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonEvolutionChain.url + "\(id)")
            return try JSONDecoder().decode(EvolutionChain.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func fetchPokemonTypeList() async -> HTTPResponse? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonTypeList.url)
            return try JSONDecoder().decode(HTTPResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func fetchGenderList() async -> HTTPResponse? {
        do {
            let data = try await NetworkAPIHandler.shared.getData(url: URLs.pokemonGenderList.url)
            return try JSONDecoder().decode(HTTPResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil

        }
    }

}

//
//  NetworkAPITests.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

final class NetworkAPITests: XCTestCase {

    var networkAPI: NetworkAPI!
    override func setUp() {
        networkAPI = NetworkAPI()
    }

    func test_fetchPokemon_list() async {
        let list = await networkAPI.fetchPokemonList()
        XCTAssertNotNil(list)
        XCTAssertTrue(list.results.count > 0)
    }

    func test_fetchPokemon_Details() async {
        let pokemon = await networkAPI.fetchPokemonDetails(url: "https://pokeapi.co/api/v2/pokemon/1/")
        XCTAssertNotNil(pokemon)
        XCTAssertEqual(pokemon?.id, 1)

        let pokemonNil = await networkAPI.fetchPokemonDetails(url: "https://pokeapi.co/api/v2/pokemon/0/")
        XCTAssertNil(pokemonNil)
    }

    func test_fetchPokemon_detailsByName() async {
        let pokemon = await networkAPI.fetchPokemonDetailsBy(name: "bulbasaur")
        XCTAssertNotNil(pokemon)
        XCTAssertEqual(pokemon?.id, 1)

        let pokemonNil = await networkAPI.fetchPokemonDetailsBy(name: "")
        XCTAssertNil(pokemonNil)
    }

    func test_fetchPokemon_description() async {
        let pokemonDescription = await networkAPI.fetchPokemonDescription(id: 1)
        XCTAssertNotNil(pokemonDescription)
        XCTAssertEqual(pokemonDescription?.id, 1)

        let pokemonDescriptionNil = await networkAPI.fetchPokemonDescription(id: 0)
        XCTAssertNil(pokemonDescriptionNil)
    }


    func test_fetch_Pokemon_evolution_chain() async {
        let evolutionChain = await networkAPI.fetchPokemonEvolutionChain(id: 1)
        XCTAssertNotNil(evolutionChain)
        XCTAssertEqual(evolutionChain?.species.name, "bulbasaur")

        let evolutionChainNil = await networkAPI.fetchPokemonEvolutionChain(id: 0)
        XCTAssertNil(evolutionChainNil)
    }

    func test_fetch_Pokemon_type_list() async {
        let list = await networkAPI.fetchPokemonTypeList()
        XCTAssertNotNil(list)
        XCTAssertEqual(list?.results.count, 20)
    }

    func test_fetch_Pokemon_gender_list() async {
        let list = await networkAPI.fetchGenderList()
        XCTAssertNotNil(list)
        XCTAssertEqual(list?.results.count, 3)
    }
}

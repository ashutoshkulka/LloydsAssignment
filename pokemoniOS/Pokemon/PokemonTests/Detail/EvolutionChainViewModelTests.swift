//
//  EvolutionChainViewModelTests.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

@MainActor
final class EvolutionChainViewModelTests: XCTestCase {

    var sut: EvolutionChainViewModel!
    var mokcNetworkAPI: MockNetworkAPI!

    override func setUp() {
        sut = EvolutionChainViewModel(networkAPI: MockNetworkAPI(),
                                pokemon: Pokemon(id: 1, name: "bulbasaur", height: 7,
                                weight: 69, gender: ["male", "female"],
                                abilities: ["overgrow", "chlorophyll"],
                                types: ["grass", "poison"],
                                imageURL: "https://test.svg"))
    }

    func testFetchEvolutionData() async {
        await sut.getPokemonList()
        XCTAssertEqual(sut.evolutionPokemonList.count, 3)
        XCTAssertEqual(sut.evolutionPokemonList.first?.name, "bulbasaur")

        let names = sut.getPockemonNames(evolutionChain: EvolutionChain(species:
                                        DetailResponse(name: "Test"),
                                        evolutionTo: [EvolutionTo(species: DetailResponse(name: "Test1"),
                                        evolutionTo: [EvolutionTo(species: DetailResponse(name: "Test3"),
                                        evolutionTo: [])])]))
        XCTAssertEqual(names.count, 3)

        let namesNil = sut.getPockemonNames(evolutionChain: EvolutionChain(species: DetailResponse(name: ""),
            evolutionTo: []))
        XCTAssertEqual(namesNil, [""])
    }
}

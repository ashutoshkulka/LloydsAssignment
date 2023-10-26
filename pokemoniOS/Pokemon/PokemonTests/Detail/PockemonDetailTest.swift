//
//  PockemonDetailTest.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

@MainActor
final class PockemonDetailTest: XCTestCase {

    var sut: PokemonDetailViewModel!
    var mokcNetworkAPI: MockNetworkAPI!

    override func setUp() {
        let pokemonDescription = PokemonDescription(id: 1,
                                                    eggGroups: ["monster", "dragon"],
                                                    description: "Test description",
                                                    genders: ["male", "female"])
        var pokemon = Pokemon(id: 1, name: "bulbasaur", height: 7,
                              weight: 69, gender: ["male", "female"],
                              abilities: ["overgrow", "chlorophyll"],
                              types: ["grass", "poison"],
                              imageURL: "https://test.svg")
        pokemon.description = pokemonDescription
        sut = PokemonDetailViewModel(networkAPI: MockNetworkAPI(), pokemon: pokemon, pokemonList: [pokemon])
    }

    func testDisplayTexts() async {
        await sut.updatePokemonDescriptions()
        XCTAssertEqual(sut.id, "001")
        XCTAssertEqual(sut.name, "BULBASAUR")
        XCTAssertEqual(sut.types, ["Grass", "Poison"])
        XCTAssertEqual(sut.eggGroups, "Monster, Dragon")
        XCTAssertEqual(sut.weight, "6.9 Kg")
        XCTAssertEqual(sut.height, "7'")
        XCTAssertEqual(sut.prevButtonText, "")
        XCTAssertEqual(sut.nextButtonText, "")
        XCTAssertEqual(sut.gender, "Male, Female")
        XCTAssertEqual(sut.weakAgainst, ["Ground", "Rock", "Water"])
        XCTAssertEqual(sut.description, "Test description")
        XCTAssertEqual(sut.stats.count, 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

    }
}

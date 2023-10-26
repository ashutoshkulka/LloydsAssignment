//
//  PokemonCellViewModelTest.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

final class PokemonCellViewModelTest: XCTestCase {

    var sut: PokemonCellViewModel!
    override func setUp() {
        sut = PokemonCellViewModel(pokemon: Pokemon(id: 1, name: "bulbasaur", height: 7,
                                                  weight: 69, gender: ["male", "female"],
                                                  abilities: ["overgrow", "chlorophyll"],
                                                  types: ["grass", "poison"],
                                                  imageURL: "https://test.svg"))
    }

    func testColorList() {
        XCTAssertEqual(sut.imageURL, "https://test.svg")
        XCTAssertEqual(sut.colors, ["grass".color, "poison".color])
        XCTAssertEqual(sut.name, "Bulbasaur")
        XCTAssertEqual(sut.id, "001")
    }
}

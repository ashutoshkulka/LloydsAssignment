//
//  EvolutionViewModelTest.swift
//  PokemonTests
//
//

import XCTest
import Combine
import SwiftUI
@testable import PokemoniOS

final class EvolutionViewModelTest: XCTestCase {

    var sut: EvolutionViewModel!
    override func setUp() {
        sut = EvolutionViewModel(pokemon: Pokemon(id: 1, name: "bulbasaur", height: 7,
                                                  weight: 69, gender: ["male", "female"],
                                                  abilities: ["overgrow", "chlorophyll"],
                                                  types: ["grass", "poison"],
                                                  imageURL: "https://test.svg"))
    }

    func testColorList() {
        XCTAssertEqual(sut.imageURL, "https://test.svg")
        XCTAssertEqual(sut.colors, ["grass".color, "poison".color])
    }
}

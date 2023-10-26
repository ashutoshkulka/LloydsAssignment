//
//  StatFilterViewModelTest.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

final class StatFilterViewModelTest: XCTestCase {

    var sut: StatFilterViewModel!
    override func setUp() {
        sut = StatFilterViewModel(title: "Stats", items: ["hp": (0, 210), "attack": (0, 210)])
    }

    func test_display_strings() {
        XCTAssertEqual(sut.displayNameFor(item: "special-defense"), "Sp. Def.")
        XCTAssertEqual(sut.displayNameFor(item: "special-attack"), "Sp. Attack")
        XCTAssertEqual(sut.itemsKeys, ["attack", "hp"])
        XCTAssertEqual(sut.headerTitle.first, "(Attack + ")
        XCTAssertEqual(sut.headerTitle.second, "1 More")
        XCTAssertEqual(sut.headerTitle.third, ")")
    }

}

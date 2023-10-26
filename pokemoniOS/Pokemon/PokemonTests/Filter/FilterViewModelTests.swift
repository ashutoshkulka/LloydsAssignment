//
//  FilterViewModelTests.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

final class FilterViewModelTests: XCTestCase {

    var sut: FilterViewModel!
    var types = ["grass": false, "poison": true]
    var genders = ["male": false, "female": true]
    var stats = ["hp": (0, 210), "attack": (0, 210)]

    override func setUp() {
        sut = FilterViewModel(filter: Filter(types: types, genders: genders, stats: stats))
    }

    func testColorList() {
        XCTAssertEqual(sut.genders, ["male": false, "female": true])
        XCTAssertEqual(sut.types, ["grass": false, "poison": true])

        sut.resetAllFilters()

        XCTAssertEqual(sut.genders, ["male": false, "female": false])
        XCTAssertEqual(sut.types, ["grass": false, "poison": false])

        sut.typeFilterListViewModel.items["grass"] = true
        sut.typeFilterListViewModel.items["poison"] = false
        sut.genderFilterListViewModel.items["male"] = true
        sut.genderFilterListViewModel.items["female"] = false

        sut.updateAddedFiilter()

        XCTAssertEqual(sut.filter.genders, ["male": true, "female": false])
        XCTAssertEqual(sut.filter.types, ["grass": true, "poison": false])
    }
}

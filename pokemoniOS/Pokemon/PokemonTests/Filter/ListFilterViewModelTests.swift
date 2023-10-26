//
//  ListFilterViewModelTests.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

final class ListFilterViewModelTests: XCTestCase {

    var sut1: ListFilterViewModel!
    var sut2: ListFilterViewModel!

    override func setUp() {
        sut1 = ListFilterViewModel(title: "Gender", items: ["male": false,
                                                           "female": false, "genderless": false])
        sut2 = ListFilterViewModel(title: "", items: [:])
    }

    func testColorList() {
        XCTAssertEqual(sut1.headerTitle.first, "(Female + ")
        XCTAssertEqual(sut1.headerTitle.second, "2 More")
        XCTAssertEqual(sut1.headerTitle.third, ")")

        XCTAssertEqual(sut2.headerTitle.first, "")
        XCTAssertEqual(sut2.headerTitle.second, "")
        XCTAssertEqual(sut2.headerTitle.third, "")
    }

    func testBind() {
        let bind = sut1.binding(key: "male")
        bind.wrappedValue = true
        XCTAssertEqual(sut1.items["male"], true)
    }
}

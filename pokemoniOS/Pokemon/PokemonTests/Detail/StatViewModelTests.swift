//
//  StatViewModelTests.swift
//  PokemonTests
//
//  Created by Avnish Kumar on 24/03/23.
//

import XCTest
import Combine
import SwiftUI
@testable import Pokemon

final class StatViewModelTests: XCTestCase {

    var sut: StatViewModel!
    override func setUp() {
        sut = StatViewModel(stats: [Stat(name: "hp", value: 56),
                                    Stat(name: "special-defense", value: 56),
                                    Stat(name: "special-attack", value: 56)])
    }

    func testColorList() {
        XCTAssertEqual(sut.stats.count, 3)
        XCTAssertEqual(sut.stats.first?.name, "Hp")
        XCTAssertEqual(sut.stats[1].name, "Sp. Def.")
        XCTAssertEqual(sut.stats[2].name, "Sp. Attack")
    }
}

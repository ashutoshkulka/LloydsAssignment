//
//  NetworkAPIHandlerTests.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

final class NetworkAPIHandlerTests: XCTestCase {
    var sut: NetworkAPIHandler!
    override func setUp() {
        sut = NetworkAPIHandler.shared
    }

    func testColorList() async {
        let data = try? await sut.getData(url: "https://www.google.com")
        XCTAssertNotNil(data)

        let dataNil = try? await sut.getData(url: "")
        XCTAssertNil(dataNil)

    }

}

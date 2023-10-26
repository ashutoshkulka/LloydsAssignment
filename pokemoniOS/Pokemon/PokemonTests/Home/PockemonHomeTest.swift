//
//  PockemonHomeTest.swift
//  PokemonTests
//
//

import XCTest
import Combine
@testable import PokemoniOS

@MainActor
final class PockemonHomeTest: XCTestCase {

    var sut: HomeViewModel!
    var mokcNetworkAPI: MockNetworkAPI!

    override func setUp() {
        mokcNetworkAPI = MockNetworkAPI()
        sut = HomeViewModel(networkAPI: MockNetworkAPI())
    }

    func test_get_pokemon_list() async {
        await sut.fetchPokemonList()
        XCTAssertNotNil(sut.pokemonList)
        XCTAssertEqual(sut.pokemonList.count, 1)
        XCTAssertEqual(sut.applyedFilterPokemonList.count, 1)
        XCTAssertEqual(sut.pokemonList.first?.id, 1)
        XCTAssertEqual(sut.pokemonList.first!.name, "bulbasaur")
        XCTAssertEqual(sut.pokemonList.first?.imageURL,
                       "https://test.svg")
        XCTAssertEqual(sut.pokemonList.first?.types, ["grass", "poison"])
        XCTAssertEqual(sut.pokemonList.first?.abilities, ["overgrow", "chlorophyll"])
        XCTAssertEqual(sut.pokemonList.first?.height, 7)
        XCTAssertEqual(sut.pokemonList.first?.weight, 69)

        let description = sut.pokemonList.first?.description
        XCTAssertEqual(description?.genders, ["male", "female"])
        XCTAssertEqual(description?.eggGroups, ["monster", "dragon"])
    }

    func test_Search() async {
        await sut.fetchPokemonList()

        sut.applySearch(searchedText: "xyz")
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 0)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.first?.name, nil)

        sut.applySearch(searchedText: "1")
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 1)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.first?.name, "bulbasaur")

        sut.applySearch(searchedText: "bul")
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 1)
        XCTAssertEqual(sut.applyedFilterPokemonList.first?.name, "bulbasaur")
    }

    func test_Fetch_FilterData()async {
        await sut.fetchPokemonList()
        let filter = self.sut.filter

        XCTAssertEqual(filter.genders.count, 3)
        XCTAssertEqual(filter.genders.keys.contains(where: {$0 == "male"}), true)

        XCTAssertEqual(filter.types.count, 20)
        XCTAssertEqual(filter.types.keys.contains(where: {$0 == "grass"}), true)

        XCTAssertEqual(filter.stats.count, 6)
        XCTAssertEqual(filter.stats.keys.contains(where: {$0 == "hp"}), true)
    }

    func test_Filters() async {
        await sut.fetchPokemonList()
        sut.filterViewModel.filter.genders["male"] = true
        sut.applyFilter(filter: self.sut.filterViewModel.filter)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 1)
        XCTAssertEqual(sut.applyedFilterPokemonList.first?.name, "bulbasaur")

        sut.filterViewModel.filter.genders["genderless"] = true
        sut.filterViewModel.filter.genders["male"] = false
        sut.applyFilter(filter: self.sut.filterViewModel.filter)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 0)

        sut.filterViewModel.filter.genders["genderless"] = false
        sut.filterViewModel.filter.types["grass"] = true
        sut.applyFilter(filter: self.sut.filterViewModel.filter)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 1)
        XCTAssertEqual(sut.applyedFilterPokemonList.first?.name, "bulbasaur")

        sut.filterViewModel.filter.types["steel"] = true
        sut.filterViewModel.filter.types["grass"] = false
        sut.applyFilter(filter: self.sut.filterViewModel.filter)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 0)

        sut.filterViewModel.filter.types["steel"] = false
        sut.filterViewModel.filter.stats["hp"] = (min: 0, max: 10)
        sut.applyFilter(filter: self.sut.filterViewModel.filter)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 0)

        sut.filterViewModel.filter.stats["hp"] = (min: 0, max: 49)
        sut.applyFilter(filter: self.sut.filterViewModel.filter)
        XCTAssertEqual(sut.applyiedFilterAndSearchPokemonList.count, 1)
        XCTAssertEqual(sut.applyedFilterPokemonList.first?.name, "bulbasaur")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

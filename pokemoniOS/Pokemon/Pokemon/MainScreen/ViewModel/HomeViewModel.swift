//
//  HomeViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {

    var networkAPI: NetworkHandlerInterface
    var pokemonList: [Pokemon] = []
    var applyedFilterPokemonList: [Pokemon] = []

    var filter = Filter()
    lazy var filterViewModel = FilterViewModel(filter: Filter())

    @Published var openFilterView: Bool = false
    @Published var fetching = false
    @Published var applyiedFilterAndSearchPokemonList: [Pokemon] = []
    @Published var searchedText: String = .empty

    var cancellables = [AnyCancellable]()

    init(networkAPI: NetworkHandlerInterface) {
        self.networkAPI = networkAPI
        self.bindData()
    }

    private func bindData() {
        $searchedText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map {$0.lowercased()}
            .sink { string in
                self.applySearch(searchedText: string)
            }
            .store(in: &cancellables)

        $openFilterView.sink { isTrue in
            if isTrue == false {
                self.applyFilter(filter: self.filterViewModel.filter)
            }
        }
        .store(in: &cancellables)
    }

    func applySearch(searchedText: String) {
        if searchedText.isEmpty {
            self.applyiedFilterAndSearchPokemonList = self.applyedFilterPokemonList
        } else {
            self.applyiedFilterAndSearchPokemonList = self.applyedFilterPokemonList.filter({ pokemon in
                if pokemon.name.contains(searchedText) || String(pokemon.id).contains(searchedText) {
                    return true
                } else {
                    return false
                }
            })
        }
    }

    func applyFilter(filter: Filter) {
        self.applyedFilterPokemonList = self.pokemonList.filter { pokemon in
            var typeMatches = false
            var genderMatches = false
            var statMatches = false

            let types = Array(filterViewModel.filter.types.filter({$1 == true}).keys)
            if types.count > 0 {
                typeMatches = types.contains { type in
                    pokemon.types.contains(where: {$0 == type})
                }
            } else {
                typeMatches = true
            }

            let genders = Array(filterViewModel.filter.genders.filter({$1 == true}).keys)
            if genders.count > 0 {
                genderMatches = genders.contains { gender in
                    if let description = pokemon.description {
                        return description.genders.contains(where: {$0 == gender})
                    } else {
                        return false
                    }
                }
            } else {
                genderMatches = true
            }

            let stats = filterViewModel.filter.stats.filter({($1.min > 0 && $1.max < 210)
                                                            || ($1.min == 0 && $1.max < 210)
                                                            || ($1.min > 0 && $1.max == 210)})
            if stats.count > 0 {
                statMatches = stats.contains { stat in
                    pokemon.stats.contains(where: {
                        return $0.name == stat.key && $0.value >= stat.value.min  && $0.value <= stat.value.max
                    })
                }
            } else {
                statMatches = true
            }
            return typeMatches && genderMatches &&  statMatches
        }
        self.applySearch(searchedText: self.searchedText.lowercased())
    }

    func fetchPokemonList()async {
        self.fetching = true
        let response = await networkAPI.fetchPokemonList()
        await withTaskGroup(of: Pokemon?.self, body: { group in
            for dict in response.results {
                if let url = dict["url"] {
                    group.addTask {
                        await self.networkAPI.fetchPokemonDetails(url: url)
                    }
                }
            }
            var pokemons = [Pokemon]()
            for await pokemon in group {
                if let pokemon = pokemon {
                    pokemons.append(pokemon)
                }
            }
            let pokemonWithDetails = await self.updatePokemonOtherDetails(pokemons: pokemons)
            self.pokemonList = pokemonWithDetails.sorted(by: {$0.id < $1.id})
            self.applyedFilterPokemonList = self.pokemonList
            self.applyiedFilterAndSearchPokemonList = self.pokemonList
        })
        await self.fetchFilterData()
        self.fetching = false
    }

    private func updatePokemonOtherDetails(pokemons: [Pokemon]) async -> [Pokemon] {
        await withTaskGroup(of: PokemonDescription?.self, body: { group in
            for pokemon in pokemons {
                    group.addTask {
                        await self.networkAPI.fetchPokemonDescription(id: pokemon.id)
                    }
            }
            var pokemonListWithDescription = [Pokemon]()
            for await pokemonDescription in group {
                if let pokemonDescription = pokemonDescription {
                    for pokemon in pokemons where pokemon.id == pokemonDescription.id {
                        var pokemon = pokemon
                        pokemon.description = pokemonDescription
                        pokemonListWithDescription.append(pokemon)
                    }
                }
            }
            return pokemonListWithDescription
        })
    }

    private func fetchFilterData()async {
        var filter = Filter()
        if let results = await networkAPI.fetchPokemonTypeList()?.results {
            let types = results.compactMap {$0}.reduce([String: Bool](), { partialResult, newVal -> [String: Bool] in
                var res = partialResult
                if let type = newVal["name"] {
                    res[type] = false
                    return res
                }
                return partialResult
            })
            filter.types = types
        }

        if let results = await networkAPI.fetchGenderList()?.results {
            let genderList = results.compactMap {$0}.reduce([String: Bool]()
                                                    , { partialResult, newVal -> [String: Bool] in
                var res = partialResult
                if let type = newVal["name"] {
                    res[type] = false
                    return res
                }
                return partialResult
            })
            filter.genders = genderList
        }
        filter.stats = defaultStats
        self.filter = filter
        self.filterViewModel.filter = filter
    }

    var defaultStats: [String: (min: Int, max: Int)] {
        return  ["hp": (min: 0, max: 210), "attack": (min: 0, max: 210),
                 "defense": (min: 0, max: 210), "special-attack": (min: 0, max: 210),
                 "special-defense": (min: 0, max: 210), "speed": (min: 0, max: 210)]
    }
}

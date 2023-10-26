//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine

@MainActor
class PokemonDetailViewModel: ObservableObject {

    let networkAPI: NetworkHandlerInterface

    private var pokemon: Pokemon
    private var pokemonList: [Pokemon]
    @Published var prevButtonText: String = .empty
    @Published var nextButtonText: String = .empty
    @Published var updatedPokemon: Pokemon
    @Published var loading: Bool = false
    @Published var evolutionChainViewModel: EvolutionChainViewModel
    @Published var weakAgainst = [String]()

    var cancellables = [AnyCancellable]()

    var name: String {
        return updatedPokemon.name.uppercased()
    }

    var id: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 3
        return numberFormatter.string(from: updatedPokemon.id as NSNumber) ?? Constants.zero
    }

    var height: String {
        return "\(updatedPokemon.height)'"
    }

    var weight: String {
        return "\(Float(updatedPokemon.weight)/10) Kg"
    }

    var gender: String {
        updatedPokemon.description?.genders.map { $0.capitalized}.joined(separator: Constants.commaeSeprator) ?? .empty
    }

    var eggGroups: String {
        updatedPokemon.description?.eggGroups.map {$0.capitalized}.joined(separator: Constants.commaeSeprator) ?? .empty
    }

    var abilities: String {
        return updatedPokemon.abilities.map {$0.capitalized}.joined(separator: Constants.commaeSeprator)
    }

    var description: String {
        return (updatedPokemon.description?.description ?? .empty).trimmingCharacters(in: .newlines)
    }

    var types: [String] {
        return updatedPokemon.types.map { $0.capitalized}
    }

    var stats: [Stat] {
        return updatedPokemon.stats
    }

    init(networkAPI: NetworkHandlerInterface, pokemon: Pokemon, pokemonList: [Pokemon]) {
        self.networkAPI = networkAPI
        self.pokemon = pokemon
        self.pokemonList = pokemonList
        self.updatedPokemon = pokemon
        self.evolutionChainViewModel = EvolutionChainViewModel(networkAPI: networkAPI, pokemon: pokemon)
    }

    func updateSelectedPokemonToDefault() {
        self.updatedPokemon = pokemon
    }

    func updatePokemonDescriptions()async {
        self.loading = true
        self.updateButtonText()
        await withTaskGroup(of: WeakAgainst?.self, body: { group in
            for type in updatedPokemon.types {
                group.addTask {
                    await self.networkAPI.fetchPokemonWeakAgainst(type: type)
                }
            }
            var weakAgainstStrings = [String]()
            for await types in group {
                if let natures = types?.natures {
                    weakAgainstStrings.append(contentsOf: natures)
                }
            }
            self.weakAgainst = weakAgainstStrings.removeDuplicates().sorted().map {$0.capitalized}
            self.loading = false
        })
    }

    func nextButtonTapped()async {
        if let index = self.pokemonList.firstIndex(where: {$0.id == updatedPokemon.id}) {
            let newIndex =  index + 1
            if index < pokemonList.count - 1 {
                updatedPokemon = pokemonList[newIndex]
                self.evolutionChainViewModel.pokemon = updatedPokemon
                await self.updatePokemonDescriptions()
            } else {
                self.updateButtonText()
            }
        }
    }

    func prevButtonTapped()async {
        if let index = self.pokemonList.firstIndex(where: {$0.id == updatedPokemon.id}) {
            let newIndex =  index - 1
            if index > 0 {
                updatedPokemon = pokemonList[newIndex]
                await self.updatePokemonDescriptions()
            } else {
                self.updateButtonText()
            }
        }
    }

    private func updateButtonText() {
        if let index = self.pokemonList.firstIndex(where: {$0.id == updatedPokemon.id}) {
            if index < pokemonList.count - 1 {
                self.nextButtonText = pokemonList[index + 1].name.capitalized
            } else {
                self.nextButtonText = .empty
            }

            if index > 0 {
                self.prevButtonText = pokemonList[index - 1].name.capitalized
            } else {
                self.prevButtonText = .empty
            }
        }
    }
}

//
//  EvolutionChainViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine

@MainActor
class EvolutionChainViewModel: ObservableObject {

    var networkAPI: NetworkHandlerInterface

    @Published var pokemon: Pokemon
    @Published var evolutionPokemonList: [Pokemon] = []

    var cancellables = [AnyCancellable]()

    func getPockemonNames(evolutionChain: EvolutionChain?) -> [String] {
        var pokemonNames = [String]()
        if let evolutionChain = evolutionChain {
            pokemonNames.append(evolutionChain.species.name)
        }
        var evolvesTo = evolutionChain?.evolvesTo ?? []
        repeat {
            guard let evolvesToData = evolvesTo.first else {
                break
            }
            pokemonNames.append(evolvesToData.species.name)
            evolvesTo = evolvesToData.evolvesTo
        }while(!evolvesTo.isEmpty)
        return pokemonNames
    }

    init(networkAPI: NetworkHandlerInterface, pokemon: Pokemon) {
        self.networkAPI = networkAPI
        self.pokemon = pokemon
        self.bindData()
    }

    private func bindData() {
        self.$pokemon.sink { _ in
            Task {
                await self.getPokemonList()
            }
        }.store(in: &cancellables)
    }

    func getPokemonList() async {
        let evolutionChain = await networkAPI.fetchPokemonEvolutionChain(id: self.pokemon.id)
        let pokemonNames = getPockemonNames(evolutionChain: evolutionChain)
        await withTaskGroup(of: Pokemon?.self, body: { group in
            for name in pokemonNames {
                group.addTask {
                    await self.networkAPI.fetchPokemonDetailsBy(name: name)
                }
            }
            var pokemonList = [Pokemon]()
            for await pokemon in group {
                if let pokemon = pokemon {
                    pokemonList.append(pokemon)
                }
            }
            self.evolutionPokemonList = pokemonList
        })
    }
}

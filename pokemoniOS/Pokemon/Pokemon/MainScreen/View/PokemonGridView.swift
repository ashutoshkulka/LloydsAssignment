//
//  PokemonGridView.swift
//  Pokemon
//
//

import SwiftUI

struct PokemonGridView: View {

    @ObservedObject var viewModel: HomeViewModel

    let gridItem = GridItem(.flexible())
    var body: some View {
        LazyVGrid(columns: [gridItem, gridItem]) {
            ForEach($viewModel.applyiedFilterAndSearchPokemonList) { pokemon in
                NavigationLink {
                    PokemonDetailView(viewModel:
                                        PokemonDetailViewModel(networkAPI: NetworkAPI(),
                                                               pokemon: pokemon.wrappedValue, pokemonList:
                                                                self.viewModel.applyiedFilterAndSearchPokemonList))
                } label: {
                    PokemonCellView(viewModel: PokemonCellViewModel(pokemon: pokemon.wrappedValue))
                        .padding(.vertical, 8)
                }
                .foregroundColor(.black)
            }
        }
        .hideKeyboardWhenTappedAround()
    }
}

#if DEBUG
struct PokemanGridView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGridView(viewModel: HomeViewModel(networkAPI: NetworkAPI()))
    }
}
#endif

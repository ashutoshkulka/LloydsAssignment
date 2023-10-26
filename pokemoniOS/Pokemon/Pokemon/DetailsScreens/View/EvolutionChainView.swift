//
//  EvolutionChainView.swift
//  Pokemon
//
//

import SwiftUI

struct EvolutionChainView: View {

    @ObservedObject var viewModel: EvolutionChainViewModel
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Text(Title.evolutionChain)
                    .modifier(TitleTextModifier2())
                Spacer()
            }
            ZStack {
                LazyHStack {
                    ForEach($viewModel.evolutionPokemonList, id: \.id) {pokemon in
                        EvolutionView(viewModel: EvolutionViewModel(pokemon: pokemon.wrappedValue))
                        if viewModel.evolutionPokemonList.firstIndex(where: {$0.id == pokemon.id})
                            != viewModel.evolutionPokemonList.count - 1 {
                            Image.rightArrow
                        }
                    }
                }
            }
        }
        .padding(.leading, 18)
        .onAppear {
            Task {
                await viewModel.getPokemonList()
            }
        }
    }
}

#if DEBUG
struct EvolutionChainView_Previews: PreviewProvider {
    @State static var url: String = .empty

    static var previews: some View {
        EvolutionChainView(viewModel: EvolutionChainViewModel(networkAPI: NetworkAPI(),
                                                              pokemon: Pokemon.preview))
    }
}
#endif

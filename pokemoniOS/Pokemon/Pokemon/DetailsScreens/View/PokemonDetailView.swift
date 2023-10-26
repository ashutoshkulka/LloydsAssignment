//
//  PokemonDetailView.swift
//  Pokemon
//
//

import SwiftUI

struct PokemonDetailView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: PokemonDetailViewModel
    @State var showMore: Bool = false

    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.screenBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 50) {
                    VStack(spacing: 0) {
                        HStack {
                            Text(viewModel.name)
                                .modifier(LargeTitleTextModifier())
                            Spacer()
                            Image.backButton
                                .resizable()
                                .frame(width: 35, height: 35)
                                .onTapGesture {
                                    self.dismiss()
                                }
                        }
                        HStack {
                            Text(viewModel.id)
                                .modifier(LargeTitleTextModifier())
                            Spacer()
                        }
                    }
                    .padding(.all, 18)
                    VStack {
                        HStack(spacing: 12) {
                            PokemonCellView(viewModel: PokemonCellViewModel(pokemon: viewModel.updatedPokemon))
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(viewModel.description)
                                        .modifier(SubTitleTextModifier())
                                    Spacer()
                                }
                                .frame(height: 200)
                                Text(Constants.readMore)
                                    .modifier(TitleTextModifier())
                                    .underline()
                                    .onTapGesture {
                                        withAnimation {
                                            self.showMore = true
                                        }
                                    }
                            }
                        }
                        .padding(.all, 18)
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(Title.height)
                                    .modifier(TitleTextModifier())
                                Text(viewModel.height)
                                    .modifier(SubTitleTextModifier())
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text(Title.weight)
                                    .modifier(TitleTextModifier())
                                Text(viewModel.weight)
                                    .modifier(SubTitleTextModifier())
                            }
                            Spacer()
                        }
                        .padding(.all, 18)
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(Title.genders)
                                    .modifier(TitleTextModifier())
                                Text(self.viewModel.gender)
                                    .modifier(SubTitleTextModifier())
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text(Title.eggGroups)
                                    .modifier(TitleTextModifier())
                                Text(viewModel.eggGroups)
                                    .modifier(SubTitleTextModifier())
                            }
                            Spacer()
                        }
                        .padding(.all, 18)
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(Title.abilities)
                                    .modifier(TitleTextModifier())
                                Text(viewModel.abilities)
                                    .modifier(SubTitleTextModifier())
                            }
                            Spacer()
                            PokemonPropertyView(title: Title.types, properties: .constant(viewModel.types))
                            Spacer()
                        }
                        .padding(.all, 18)
                        PokemonPropertyView(title: Title.weakAgainst, properties: $viewModel.weakAgainst)
                            .padding(.all, 18)
                        StatsView(viewModel: StatViewModel(stats: viewModel.stats))
                        EvolutionChainView(viewModel: self.viewModel.evolutionChainViewModel)
                    }
                    HStack {
                        if !viewModel.prevButtonText.isEmpty {
                            ArrowButton(text: viewModel.prevButtonText, direction: .left)
                                .onTapGesture {
                                    Task {
                                        await viewModel.prevButtonTapped()
                                    }
                                }
                        }
                        Spacer()
                        if !viewModel.nextButtonText.isEmpty {
                            ArrowButton(text: viewModel.nextButtonText, direction: .right)
                                .onTapGesture {
                                    Task {
                                        await viewModel.nextButtonTapped()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 18)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if $showMore.wrappedValue {
                PopupTextView(text: viewModel.description
                              , showPopup: self.$showMore)
            }
            if viewModel.loading {
                ProgressView(Constants.loading)
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .padding(.top, 50)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            Task {
                viewModel.updateSelectedPokemonToDefault()
                await viewModel.updatePokemonDescriptions()
            }
        }
    }
}

#if DEBUG
struct PokemonDetailView_Previews: PreviewProvider {
    @State static var pokemon = Pokemon.preview

    static var previews: some View {
        PokemonDetailView(viewModel: PokemonDetailViewModel(networkAPI: NetworkAPI(), pokemon: pokemon,
                        pokemonList: [pokemon]))
    }
}
#endif

//
//  HomeView.swift
//  Pokemon
//
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel  = HomeViewModel(networkAPI: NetworkAPI())

    var body: some View {
        NavigationStack {
            ZStack {
                Color.screenBackground
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 18) {
                        HStack {
                            Text(Title.pokedex)
                                .modifier(LargeTitleTextModifier())
                            Spacer()
                        }
                        Divider()
                            .background(Color.blue)
                        Text(Title.homeDescription)
                            .modifier(SubTitleTextModifier())
                        HStack {
                            SearchBarView(searchText: $viewModel.searchedText)
                            Image.filter
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .padding(.all, 8)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.openFilterView = true
                                    }
                                }
                        }
                        .disabled(viewModel.fetching)

                        if !viewModel.fetching {
                            PokemonGridView(viewModel: viewModel)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
                .padding(.top, 12)
                .padding(.bottom, 0)
                .padding(.horizontal, 18)
                if $viewModel.openFilterView.wrappedValue == true {
                    FilterView(viewModel: viewModel.filterViewModel, showPopup: $viewModel.openFilterView)
                }
                if viewModel.fetching {
                    ProgressView(Constants.fetchingData)
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .padding(.top, 150)
                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
        .hideKeyboardWhenTappedAround()
        .onAppear {
            Task {
                await viewModel.fetchPokemonList()
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif

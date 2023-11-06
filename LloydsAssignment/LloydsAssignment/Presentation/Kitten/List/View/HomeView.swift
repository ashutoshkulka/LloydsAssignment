//
//  HomeView.swift
//  HomeView
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI

/// The main view displaying a list of kittens or an error message in case of failure.
struct HomeView <ViewModel>: View where ViewModel: HomeViewModelUseCase {
    
    /// The view model responsible for managing home-related data and actions.
    @ObservedObject var homeViewModel: ViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(Constants.String.title)
        }
        .onAppear {
            homeViewModel.fetchAllKittens()
        }
    }
    
    /// The content view displaying either a loading spinner or the fetched photos.
    private var content: some View {
        Group {
            if homeViewModel.isLoading {
                LoadingView()
            } else if let  errorMessage = homeViewModel.errorMessage {
                ErrorView(errorMessage: errorMessage) {
                    //On retry button refresh Kittens List
                    homeViewModel.fetchAllKittens()
                }
            } else {
                if let kittens = homeViewModel.kittenDomainDataList?.kittenDomainData {
                    List(kittens, id: \.otherID) { kitten in
                        NavigationLink {
                            KittenDetailView(kitten: kitten)
                        } label: {
                            KittenRow(kitten: kitten)
                        }
                    }
                } else {
                    VStack()  {
                        Text(Constants.String.noData)
                    }
                }
            }
        }
    }
}


//
//  ErrorView.swift
//  ErrorView
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI

/// A view displayed when an error occurs in the app.
struct ErrorView: View {
    /// The view model responsible for handling home-related data and actions.
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text(Constants.String.errorMessage)
            Text(homeViewModel.errorMessage ?? "")
            Button {
                homeViewModel.fetchAllKittens()
            } label: {
                Text(Constants.String.tryAgain)
            }
        }
    }
}

/// A preview provider for the ErrorView struct.
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(homeViewModel: HomeViewModel())
    }
}

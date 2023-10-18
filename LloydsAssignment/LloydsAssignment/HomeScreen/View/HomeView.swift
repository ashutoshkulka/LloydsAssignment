//
//  HomeView.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI
private typealias Padding = Constants.Paddings

/// The main view displaying a list of photos fetched from the network.
struct HomeView: View {
    /// The observed view model managing the data and state for this view.
    @ObservedObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(Constants.String.title)
                .onAppear {
                    homeViewModel.fetchAndDownloadPhotos()
                }
        }
    }
    
    /// The content view displaying either a loading spinner or the fetched photos.
    private var content: some View {
        Group {
            if homeViewModel.isLoading {
                ProgressView()
            } else {
                PhotoListView(photoModel: homeViewModel.photos)
            }
        }
    }
}

/// A view displaying a list of photos in a vertical scrollable list.
struct PhotoListView: View {
    /// The array of UIImage objects representing photos to be displayed.
    let photoModel: [PhotoModel]
    
    var body: some View {
        List(photoModel, id: \.photo.url) { photo in
            VStack(spacing: .zero) {
                Text(photo.photo.title)
                    .font(.headline)
                    .padding()
                
                Text(Constants.String.albumID + String(photo.photo.id))
                    .font(.headline)
                    .padding()
                Image(uiImage: photo.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.Paddings.size200)
                    .padding(.horizontal, Padding.size10)
                    .padding(.vertical, Padding.size10)
                    .padding(.horizontal, .zero)
            }.padding(.horizontal, .zero)
        }
    }
}

/// A preview provider for HomeView to enable live previews in Xcode.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

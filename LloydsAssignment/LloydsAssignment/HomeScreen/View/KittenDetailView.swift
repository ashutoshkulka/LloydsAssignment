//
//  KittenDetailView.swift
//  KittenDetailView
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI
import Kingfisher

private typealias Padding = Constants.Paddings

/// A view displaying detailed information about a specific kitten, including its image, title, description, and URL.
struct KittenDetailView: View {
    /// The kitten object containing detailed information about the displayed kitten.
    let kitten: Kitten
    
    var body: some View {
        ScrollView {
            VStack {
                if let url = URL(string: kitten.url) {
                    // Display the kitten image asynchronously
                    KFImage(url)
                        .placeholder { progress in
                            ProgressView(progress)
                        }
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(maxHeight: Padding.size300)
                } else {
                    // Display a gray placeholder if the URL is invalid
                    Color.gray.frame(height: Padding.size300)
                }
                // Display the kitten title, description, and URL
                VStack(alignment: .leading,
                       spacing: Padding.size15) {
                    Text(kitten.title)
                        .font(.headline)
                    Text(kitten.description)
                        .font(.footnote)
                    Text(kitten.url)
                    Spacer()
                }.padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(kitten.title)
            }
        }
    }
}


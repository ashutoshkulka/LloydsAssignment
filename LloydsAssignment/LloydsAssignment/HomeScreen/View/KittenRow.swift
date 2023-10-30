//
//  KittenRow.swift
//  KittenRow
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI
import Kingfisher
private typealias Padding = Constants.Paddings

/// A view representing a row displaying information about a kitten, including its image, title, and description.
struct KittenRow: View {
    /// The kitten object containing information about the kitten to be displayed in the row.
    
    let kitten: Kitten
    
    var body: some View {
        HStack {
            if let url = URL(string: kitten.url) {
                KFImage(url)
                    .placeholder { p in
                        ProgressView(p)
                    }.scaledToFill()
                    .frame(width: Padding.size100,
                           height: Padding.size100)
                    .clipped().clipShape(.circle)
                
            }else {
                Color.gray.frame(width: Padding.size100,
                                 height: Padding.size100)
            }
            VStack(alignment: .leading,
                   spacing: Padding.size10) {
                Text(kitten.title).font(.headline)
                Text(kitten.description)
                    .font(.subheadline).lineLimit(Padding.size2)
            }
        }
    }
}


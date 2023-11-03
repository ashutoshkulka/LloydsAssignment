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
    
    let kitten: KittenData
    
    var body: some View {
        HStack {
            if let url = URL(string: kitten.imageUrl) {
                KFImage(url)
                    .placeholder { image in
                        ProgressView(image)
                    }.scaledToFill()
                    .frame(width: Padding.size50,
                           height: Padding.size50)
                    .clipped().clipShape(.circle)
                
            }else {
                Color.gray.frame(width: Padding.size50,
                                 height: Padding.size50)
            }
            VStack(alignment: .leading,
                   spacing: Padding.size10) {
                Text(kitten.name).font(.headline)
                Text(kitten.description)
                    .font(.subheadline).lineLimit(Padding.size2)
            }
        }
    }
}


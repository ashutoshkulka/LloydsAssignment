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
    /// The kittenDomainObject object containing information about the kitten to be displayed in the row.
    let kittenDomainObject: KittenDomainObject
    
    var body: some View {
        HStack {
            if let url = URL(string: kittenDomainObject.imageUrl) {
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
                Text(kittenDomainObject.name).font(.headline)
                Text(kittenDomainObject.description)
                    .font(.subheadline).lineLimit(Padding.size2)
            }
        }
    }
}


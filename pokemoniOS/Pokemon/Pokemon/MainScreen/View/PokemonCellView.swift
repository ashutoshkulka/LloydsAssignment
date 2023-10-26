//
//  PokemonCellView.swift
//  PokemonUIComponents
//
//

import SwiftUI
import Kingfisher
import SVGKit

struct PokemonCellView: View {

    @ObservedObject var viewModel: PokemonCellViewModel

    var body: some View {
        VStack {
            KFImage.url(URL(string: viewModel.imageURL))
                .setProcessor(ImageDataConverted()
                    )
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(viewModel.name)
                .modifier(TitleTextModifier())
            Text(viewModel.id)
                .modifier(SubTitleTextModifier())
        }
        .frame(width: 124, height: 194)
        .padding()
        .background {
            LinearGradient(colors: viewModel.colors, startPoint: .top, endPoint: .bottom)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(RoundedRectangle(cornerRadius: 15)
        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [7], dashPhase: 0.0)))
    }
}

#if DEBUG
struct PokemonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCellView(viewModel: PokemonCellViewModel(pokemon: Pokemon.preview))
    }
}
#endif

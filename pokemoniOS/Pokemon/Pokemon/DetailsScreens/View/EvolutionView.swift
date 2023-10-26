//
//  EvolutionView.swift
//  PokemonUIComponents
//
//

import SwiftUI
import Kingfisher

struct EvolutionView: View {

    @State private var phase = 5.0
    @ObservedObject var viewModel: EvolutionViewModel

    var body: some View {
        VStack {
            KFImage.url(URL(string: viewModel.pokemon.imageURL))
                .setProcessor(ImageDataConverted())
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
        .frame(width: 60, height: 100)
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
struct EvolutionView_Previews: PreviewProvider {
    static var url: String = .empty
    static var previews: some View {
        EvolutionView(viewModel: EvolutionViewModel(pokemon: Pokemon.preview))
    }
}
#endif

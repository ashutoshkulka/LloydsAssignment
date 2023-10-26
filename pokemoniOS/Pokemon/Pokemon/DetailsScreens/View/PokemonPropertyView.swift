//
//  PokemonPropertyView.swift
//  Pokemon
//
//

import SwiftUI

struct PokemonPropertyView: View {
    @State var title: String
    @Binding var properties: [String]
    var rows = [GridItem(.adaptive(minimum: 70), spacing: 2)]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .modifier(TitleTextModifier())
                .bold()
            HStack {
                LazyVGrid(columns: rows, spacing: 8) {
                    ForEach(properties, id: \.self) {property in
                        Text(property)
                            .modifier(TitleTextModifier())
                            .padding(.horizontal, 5)
                            .frame(width: 75, height: 20)
                            .background(property.lowercased().color)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                    }
                    .padding(.horizontal, 0)
                }
                .padding(.horizontal, 0)
            }
        }
    }
}

#if DEBUG
struct PokemanPropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPropertyView(title: "Sample", properties: .constant(["Sample1", "Sample2", "Sample3"]))
    }
}
#endif

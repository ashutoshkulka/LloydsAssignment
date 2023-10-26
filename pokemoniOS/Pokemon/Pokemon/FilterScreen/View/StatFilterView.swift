//
//  StatFilterView.swift
//  Pokemon
//
//

import SwiftUI

struct StatFilterView: View {

    @ObservedObject var viewModel: StatFilterViewModel
    @State private var expand: Bool = false

    var gridItem = GridItem(.flexible())
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.title)
                    .modifier(TitleTextModifier())
                Spacer()
                Divider()
                    .background(Color.black)
                Text(viewModel.headerTitle.first)
                    + Text(viewModel.headerTitle.second).bold()
                    + Text(viewModel.headerTitle.third)
                Spacer()
                (expand ? Image.minus:Image.plus)
                    .onTapGesture {
                        expand.toggle()
                    }
            }
            .frame(height: 25)
            if expand {
                Divider()
                    .background(Color.black)
                LazyVGrid(columns: [gridItem]) {
                    ForEach(viewModel.itemsKeys, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Text(viewModel.displayNameFor(item: item))
                                .modifier(SubTitleTextModifier())
                            RangeSliderView(currentValue: viewModel.binding(key: item),
                                            sliderBounds: viewModel.sliderBounds)
                        }
                    }
                }
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
        .padding()
    }
}

#if DEBUG
struct StatFilterView_Previews: PreviewProvider {
    static var previews: some View {
        StatFilterView(viewModel: StatFilterViewModel(title: "Stats",
                                  items: ["HP": (min: 123, max: 195)]))
    }
}
#endif

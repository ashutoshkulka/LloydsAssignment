//
//  ListFilterView.swift
//  Pokemon
//
//

import SwiftUI

struct ListFilterView: View {

    @ObservedObject var viewModel: ListFilterViewModel
    @State var expand: Bool = false

    var gridItem = GridItem(.flexible(minimum: 100, maximum: 200))
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
                        withAnimation {
                            expand.toggle()
                        }
                    }
            }
            .frame(height: 25)
            if expand {
                Divider()
                    .background(Color.black)
                LazyVGrid(columns: [gridItem, gridItem]) {
                    ForEach(viewModel.itemsKeys, id: \.self) {key in
                        CheckBoxView(title: key, isChecked: viewModel.binding(key: key))
                           .padding()
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
struct FilterCellView_Previews: PreviewProvider {
    static var previews: some View {
        ListFilterView(viewModel: ListFilterViewModel(title: "Type",
                      items: ["Normal": false, "Flying": false, "Test1": false,
                      "Test14": false, "Test15": true]))
    }
}
#endif

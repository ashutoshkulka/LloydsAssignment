//
//  SearchField.swift
//  Pokemon
//
//
import SwiftUI

struct SearchBarView: View {

    @Binding var searchText: String

    var body: some View {
        HStack {
            HStack {
                TextField(Constants.searchFieldPlaceholder, text: $searchText).foregroundColor(.primary)
                Image.magnifyingGlass
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .frame(height: 50)
        .foregroundColor(.secondary)
        .background(Color(.tertiarySystemFill))
        .cornerRadius(10.0)
    }
}

#if DEBUG
struct SearchField_Previews: PreviewProvider {
    @State static var text: String = .empty
    static var previews: some View {
       SearchBarView(searchText: $text)
    }
}
#endif

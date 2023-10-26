//
//  Utility.swift
//  PokemoniOS
//
//  Created by Ashutosh Kulkarni on 25/10/23.
//

import Foundation
import SwiftUI

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var buffer = Array()
               var added = Set<Element>()
               for elem in self where added.contains(elem) == false {
                       buffer.append(elem)
                       added.insert(elem)
               }
               return buffer
    }

    func removeDuplicates() -> Self {
        return self.removingDuplicates()
    }
}

extension String {
    var color: Color {
        return Color(self)
    }

    static let empty = ""
}


extension Color {
    static let screenBackground = Color("screenBackgroundColor")
    static let titleText = Color("titleTextColor")
    static let placeholderText = Color("placeholderTextColor")
    static let statsBackground = Color("statsBackground")
    static let popupBackground = Color("popupBackground")
    static let slider = Color("grass")
}

extension View {
    func hideKeyboardWhenTappedAround() -> some View {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                  to: nil, from: nil, for: nil)
        }
    }
}

extension Image {
    static let magnifyingGlass = Image("magnifyingglass")
    static let backButton = Image("backButton")
    static let filter = Image("filter_icon")
    static let plus = Image(systemName: "plus.circle")
    static let minus = Image(systemName: "minus.circle")
    static let checkedCheckBox = Image(systemName: "checkmark.square.fill")
    static let uncheckedCheckBox = Image(systemName: "square")
    static let rightArrow = Image(systemName: "arrow.right")
    static let leftArrow = Image(systemName: "arrow.left")
}

extension Font {
    static let largeTitleText = Font.custom("Roboto", fixedSize: 30)
    static let titleText = Font.custom("Roboto", fixedSize: 16)
    static let titleText2 = Font.custom("Roboto", fixedSize: 20)
}

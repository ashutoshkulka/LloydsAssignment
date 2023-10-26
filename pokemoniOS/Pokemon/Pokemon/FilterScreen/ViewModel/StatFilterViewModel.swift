//
//  StatFilterViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine
import SwiftUI

class StatFilterViewModel: ObservableObject {
    @Published var title: String
    @Published var items: [String: (min: Int, max: Int)]
    @Published var sliderBounds: ClosedRange<Int> = (0...210)

    var itemsKeys: [String] {
        return Array(items.keys).sorted()
    }

    var headerTitle: HeaderTitle {
        let itemsKeyArray = itemsKeys
        var title: HeaderTitle = HeaderTitle(first: .empty, second: .empty, third: .empty)
        if let firstItemKey = itemsKeyArray.first {
            title.first = "(\(firstItemKey.capitalized) + "
            title.second = itemsKeyArray.count > 1 ? "\(itemsKeyArray.count - 1) More":.empty
            title.third = ")"
        }
        return title
    }

    init(title: String, items: [String: (min: Int, max: Int)]) {
        self.title = title
        self.items = items
    }

    func binding(key: String) -> Binding<(ClosedRange<Float>)> {
        Binding {
            if let item = self.items[key] {
                return (Float(item.min)...Float(item.max))
            } else {
                return (0...210)
            }
        } set: {
            self.items[key] = (Int($0.lowerBound), Int($0.upperBound))
        }
    }

    func displayNameFor(item: String) -> String {
        if item ==  "special-defense" {
            return "Sp. Def."
        } else if item == "special-attack" {
            return "Sp. Attack"
        } else {
            return item.capitalized
        }
    }
}

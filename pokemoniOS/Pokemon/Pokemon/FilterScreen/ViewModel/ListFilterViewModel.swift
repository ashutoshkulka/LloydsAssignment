//
//  ListFilterViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine
import SwiftUI

struct HeaderTitle {
    var first: String
    var second: String
    var third: String
}

class ListFilterViewModel: ObservableObject {
    @Published var title: String
    @Published var items: [String: Bool]

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

    init(title: String, items: [String: Bool]) {
        self.title = title
        self.items = items
    }

    func binding(key: String) -> Binding<Bool> {
        Binding {
            return self.items[key] ?? false
        } set: {
            self.items[key] = $0
        }
    }
}

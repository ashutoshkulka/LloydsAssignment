//
//  FilterViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine

class FilterViewModel: ObservableObject {
    @Published var filter: Filter

    lazy var genderFilterListViewModel = ListFilterViewModel(title: Title.gender, items: self.genders)
    lazy var typeFilterListViewModel = ListFilterViewModel(title: Title.type, items: self.types)
    lazy var statFilterViewModel = StatFilterViewModel(title: Title.stats, items: filter.stats)

    var types: [String: Bool] {
        return filter.types
    }

    var genders: [String: Bool] {
        return filter.genders
    }

    init(filter: Filter) {
        self.filter = filter
    }

    func updateAddedFiilter() {
        self.filter.types = typeFilterListViewModel.items
        self.filter.genders = genderFilterListViewModel.items
        self.filter.stats = statFilterViewModel.items
    }

    func resetAllFilters() {
        self.filter.types =  typeFilterListViewModel.items.mapValues {_ in false}
        self.filter.genders =  genderFilterListViewModel.items.mapValues {_ in false}
        self.filter.stats = statFilterViewModel.items.mapValues {_ in (min: 0, max: 210)}
        self.typeFilterListViewModel.items = self.filter.types
        self.genderFilterListViewModel.items = self.filter.genders
        self.statFilterViewModel.items = self.filter.stats
    }
}

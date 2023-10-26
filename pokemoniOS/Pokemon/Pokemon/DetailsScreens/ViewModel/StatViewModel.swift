//
//  StatViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine

class StatViewModel: ObservableObject {
    @Published var stats: [Stat]

    init(stats: [Stat]) {
        self.stats = stats.map {stat in
            var stat = stat
            if stat.name ==  "special-defense" {
                stat.name = "Sp. Def."
            } else if stat.name == "special-attack" {
                stat.name = "Sp. Attack"
            } else {
                stat.name = stat.name.capitalized
            }
            return stat
        }
    }
}

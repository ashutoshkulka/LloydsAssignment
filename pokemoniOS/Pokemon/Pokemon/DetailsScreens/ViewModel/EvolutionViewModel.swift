//
//  EvolutionToViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine
import SwiftUI

class EvolutionViewModel: ObservableObject {

    @Published var pokemon: Pokemon

    var imageURL: String {
        return pokemon.imageURL
    }

    var colors: [Color] {
        return pokemon.types.map {$0.color}
    }

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}

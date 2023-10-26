//
//  PokemonCellViewModel.swift
//  Pokemon
//
//

import Foundation
import Combine
import SwiftUI

class PokemonCellViewModel: ObservableObject {

    @Published var pokemon: Pokemon

    var id: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 3
        return numberFormatter.string(from: pokemon.id as NSNumber) ?? Constants.zero
    }

    var imageURL: String {
        return pokemon.imageURL
    }

    var name: String {
        return pokemon.name.capitalized
    }

    var colors: [Color] {
        return pokemon.types.map {$0.color}
    }

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}

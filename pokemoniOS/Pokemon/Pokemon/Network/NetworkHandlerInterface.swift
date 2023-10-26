//
//  NetworkHandlerInterface.swift
//  PokemoniOS
//
//  Created by Ashutosh Kulkarni on 26/10/23.
//

import Foundation

protocol NetworkHandlerInterface {
    func fetchPokemonList() async -> HTTPResponse
    func fetchPokemonDetails(url: String) async -> Pokemon?
    func fetchPokemonDescription(id: Int) async -> PokemonDescription?
    func fetchPokemonWeakAgainst(type: String) async -> WeakAgainst?
    func fetchPokemonEvolutionChain(id: Int) async -> EvolutionChain?
    func fetchPokemonTypeList() async -> HTTPResponse?
    func fetchGenderList() async -> HTTPResponse?
    func fetchPokemonDetailsBy(name: String) async -> Pokemon?
}

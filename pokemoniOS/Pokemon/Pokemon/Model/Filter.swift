//
//  Filter.swift
//  Pokemon
//
//

import Foundation

struct Filter {
    var types: [String: Bool] = [:]
    var genders: [String: Bool] = [:]
    var stats: [String: (min: Int, max: Int)] = [:]
}

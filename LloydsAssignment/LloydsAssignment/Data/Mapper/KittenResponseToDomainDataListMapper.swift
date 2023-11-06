//
//  KittenResponseToDomainDataListMapper.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 05/11/23.
//

import Foundation

/// Protocol defining the contract for a mapper responsible for mapping `KittenResponse` to `KittenDomainModel`.
class KittenResponseToDomainDataListMapper: KittensDomainDataMapperProtocol {
    /// Maps the provided `KittenResponse` object to a `KittenDomainModel`.
    ///
    /// - Parameter response: The `KittenResponse` object to be mapped.
    /// - Returns: A `KittenDomainModel` object containing mapped domain data.
    func mapToDomainDataList(response: KittenResponse) -> KittenDomainModel {
        let domainDataList = KittenDomainModel(kittenDomainObjects: response.data.map { kitten in
            return KittenDomainObject(name: kitten.title, description: kitten.description, imageUrl: kitten.url)
        })
        return domainDataList
    }
}

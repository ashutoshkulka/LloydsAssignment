//
//  KittenResponseToDomainDataListMapper.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 05/11/23.
//

import Foundation

class KittenResponseToDomainDataListMapper: KittensDomainDataMapperProtocol {
    func mapToDomainDataList(response: KittenResponse) -> KittenDomainDataList {
        let domainDataList = KittenDomainDataList(kittenDomainData: response.data.map { kitten in
            return KittenDomainData(name: kitten.title, description: kitten.description, imageUrl: kitten.url)
        })
        return domainDataList
    }
}

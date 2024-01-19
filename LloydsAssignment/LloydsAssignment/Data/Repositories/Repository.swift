//
//  Repository.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import Foundation

class Repository: RepositoryProtocol {
    /// The service responsible for providing data fetching functionalities.
    private let service: ServiceProtocol
    /// An object conforming to `KittensDomainDataMapperProtocol` responsible for mapping data from `KittenResponse` to `KittenDomainModel`.
    private var mapper: KittensDomainDataMapperProtocol
    /// Initializes the interactor with a specific repository.
    ///
    /// - Parameter service: An object conforming to `ServiceProtocol` protocol, providing data fetching functionalities. and mapper to Map data to DomainData
    init(service: ServiceProtocol, mapper: KittensDomainDataMapperProtocol) {
        self.service = service
        self.mapper = mapper
    }
    
    /// Fetches data of the specified type from the provided URL using the associated repository.
    ///
    /// - Parameters:
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func fetchAllKittens(completion: @escaping (ResponseDataProvider) -> Void) {
        service.fetchAllKittens() { result in
            switch result {
            case .success(let kittenResponse):
                // Use the mapper to convert the decoded data to the domain model
                completion(.success(self.mapper.mapToDomainDataList(response: kittenResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

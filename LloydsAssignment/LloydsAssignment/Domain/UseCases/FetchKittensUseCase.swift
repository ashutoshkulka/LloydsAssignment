//
//  FetchKittensUseCase.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import Foundation

class FetchKittensUseCase: FetchKittensUseCaseProtocol {
    /// The repository responsible for providing data fetching functionalities.
   private let repository: APIServiceRepositoryProtocol
    /// An object conforming to `KittensDomainDataMapperProtocol` responsible for mapping data from `KittenResponse` to `KittenDomainDataList`.
    var mapper: KittensDomainDataMapperProtocol
    /// Initializes the interactor with a specific repository.
    ///
    /// - Parameter repository: An object conforming to `APIServiceRepositoryProtocol` protocol, providing data fetching functionalities.
    init(repository: APIServiceRepositoryProtocol, mapper: KittensDomainDataMapperProtocol) {
        self.repository = repository
        self.mapper = mapper
    }
    
    /// Fetches data of the specified type from the provided URL using the associated repository.
    ///
    /// - Parameters:
    ///   - url: The URL from which to fetch the data.
    ///   - completion: A closure to be called once the fetch operation is completed. It contains a `Result` object representing either the decoded data or an error.
    func fetchAllKittens(url: URL?, completion: @escaping (ResponseDomainDataProvider) -> Void) {
        repository.execute(KittenResponse.self, url: url) { result in
            switch result {
            case .success(let decodedData):
                if let decodedData = decodedData as? KittenResponse {
                    // Use the mapper to convert the decoded data to the domain model
                    let domainData = self.mapper.mapToDomainDataList(response: decodedData)
                    completion(.success(domainData))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

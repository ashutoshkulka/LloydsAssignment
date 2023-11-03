//
//  HomeViewModelUseCase.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni on 03/11/23.
//

import Foundation

/// Protocol defining the contract for a view model use case responsible for managing kittens data on the home screen.
protocol HomeViewModelUseCase: ObservableObject {
    /// Represents the result of a data provider operation, containing either a value of type `T` or an API error.
    typealias ResponseDataProvider<T> = Swift.Result<T, APIError>
    /// An array of kittens fetched from the data source.
    var kittens: [KittenData]? { get }
    /// An optional error message indicating any issues occurred during the data fetch operation.
    var errorMessage: String? { get }
    /// A boolean value indicating whether data is currently being loaded.
    var isLoading: Bool { get }
    /// Fetches all kittens from the data source.
    func fetchAllKittens()
    /// Initializes the HomeViewModelUseCase with a FetchKittensUseCase instance.
    ///
    /// - Parameter fetchKittensUseCase: An instance conforming to the FetchKittensUseCase protocol, responsible for fetching kittens.
    init(fetchKittensUseCase: FetchKittensUseCaseProtocol)
}


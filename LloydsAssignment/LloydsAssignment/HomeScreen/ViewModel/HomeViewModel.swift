//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Ashutosh Kulkarni.//

import Foundation

/// View model responsible for managing the state and data related to displaying a list of kittens.
class HomeViewModel: ObservableObject {
    /// The use case responsible for fetching kittens from the API.
    private let fetchKittensUseCase: FetchKittensUseCase
    /// The list of fetched kittens. It's an optional array of `Kitten` objects.
    @Published var kittens: [Kitten]?
    /// An error message to display in case of fetching failure.
    @Published var errorMessage: String?
    /// A boolean flag indicating whether the data is currently being loaded.
    @Published var isLoading: Bool = false
    
    /// Initializes the `HomeViewModel` with a specified fetchKittensUseCase.
    ///
    /// - Parameter fetchKittensUseCase: An object conforming to `FetchKittensUseCase` protocol, responsible for fetching kittens.
    init(fetchKittensUseCase: FetchKittensUseCase) {
        self.fetchKittensUseCase = fetchKittensUseCase
    }
    
    /// Fetches a list of kittens from the API using the `fetchKittensUseCase`.
    ///
    /// This method initiates the process of fetching kittens from the API. It sets `isLoading` to `true` to indicate that the data is being fetched.
    /// After the fetch operation completes, the `isLoading` flag is set to `false`.
    /// If the fetch operation is successful, the `kittens` property is updated with the fetched data. If the fetch operation fails, the `errorMessage` property is set with the localized description of the error.
    func fetchAllKittens() {
        isLoading = true
        errorMessage = nil
        // Construct the URL for fetching kittens from the API.
        let url = URL(string: Constants.URLPath.photosURL)
        fetchKittensUseCase.execute(KittenResponse.self, url: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let kittens):
                    if let kittensResponse = kittens as? KittenResponse {
                        self?.kittens = kittensResponse.data
                    } else {
                        self?.errorMessage = Constants.String.noData
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

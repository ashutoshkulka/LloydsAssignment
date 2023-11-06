//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Ashutosh Kulkarni.//

import Foundation

/// A view model responsible for managing the state and data related to displaying a list of kittens.
class HomeViewModel: HomeViewModelUseCase, ObservableObject {
    /// Published property holding an array of kittens.
    @Published var kittenDomainDataList: KittenDomainDataList?
    /// Published property holding an error message, if any, occurred during the data fetch.
    @Published var errorMessage: String?
    /// Published property indicating whether the data is currently being loaded.
    @Published var isLoading: Bool = false
    /// The use case responsible for fetching kittens.
    private let fetchKittensUseCase: FetchKittensUseCaseProtocol
 
    /// Initializes the view model with a given fetchKittensUseCase.
    /// - Parameter fetchKittensUseCase: The use case responsible for fetching kittens.
    required init(fetchKittensUseCase: FetchKittensUseCaseProtocol) {
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
        fetchKittensUseCase.fetchAllKittens(url: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let kittens):
                    self?.kittenDomainDataList = kittens
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

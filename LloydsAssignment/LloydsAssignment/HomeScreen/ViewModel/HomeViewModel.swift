//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Ashutosh Kulkarni.//

import Foundation

/// A view model class responsible for managing kitten data.
class HomeViewModel: ObservableObject {
    /// Published property representing an array of kitten objects.
    @Published var kittens: [Kitten]?
    /// Published property indicating whether the data is currently being loaded.
    @Published var isLoading: Bool = false
    /// Published property representing any error messages that might occur during data fetching.
    @Published var errorMessage: String? = nil
    /// The service responsible for making API requests.
    let service: APIServiceProtocol

    /// Initializes the HomeViewModel with an optional APIServiceProtocol implementation.
    ///
    /// - Parameter service: An object conforming to APIServiceProtocol. Default is APIService().
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    /// Fetches a list of kittens from the API.
    ///
    /// - Note: Updates the `kittens`, `isLoading`, and `errorMessage` properties based on the result of the API request.
    func fetchAllKittens() {
        isLoading = true
        errorMessage = nil
        
        // Construct the URL for fetching kittens from the API.
        let url = URL(string: Constants.URLPath.photosURL)
        
        // Make an API request to fetch kittens.
        service.fetchKittens(KittenResponse.self, url: url) { [unowned self] result in
            // Update UI-related properties on the main thread.
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    // Handle API request failure.
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let kittens):
                    // Handle API request success.
                    print("--- success with \(kittens)")
                    self.kittens = kittens.data
                }
            }
        }
    }
}

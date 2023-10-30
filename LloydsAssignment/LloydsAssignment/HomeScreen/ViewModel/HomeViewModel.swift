//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Ashutosh Kulkarni.//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var kittens: [Kitten]?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    func fetchAllKittens() {
        isLoading = true
        errorMessage = nil
        let url = URL(string: Constants.URLPath.photosURL)
        service.fetchKittens(KittenResponse.self, url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let kittens):
                    print("--- sucess with \(kittens)")
                    self.kittens = kittens.data
                }
            }
        }
        
    }
}

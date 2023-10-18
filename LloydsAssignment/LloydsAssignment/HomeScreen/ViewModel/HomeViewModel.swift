//
//  HomeViewModel.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import Foundation
import Alamofire
import PromiseKit
private typealias URLPath = Constants.URLPath

/// The view model responsible for managing data related to photos in the home screen.
class HomeViewModel: ObservableObject {
    /// The array of downloaded images.
    @Published var photos: [PhotoModel] = []
    /// A boolean flag indicating whether the data is currently being loaded.
    @Published var isLoading: Bool = true
    
    /// Fetches a list of `Photo` objects from a specified URL.
    /// - Returns: A promise that resolves to an array of `Photo` objects.
    private func fetchPhotos() -> Promise<[Photo]> {
        return Promise { seal in
            AF.request(URLPath.photosURL, method: .get).validate().responseData { (data) in
                guard let data = data.value else {
                    seal.reject(ApplicationError.invalidPhotoURL)
                    return
                }
                guard let photos = try? JSONDecoder().decode([Photo].self, from: data) else {
                    seal.reject(ApplicationError.invalidPhotData)
                    return
                }
                seal.fulfill(photos)
            }
        }
    }
    
    /// Downloads images from an array of URLs and updates the `photos` array.
    /// - Parameter urls: An array of URLs from which images will be downloaded.
    /// - Returns: A promise that resolves to an array of downloaded `UIImage` objects.
    private func downloadPhotos(urls: [Photo]) -> Promise<[PhotoModel]> {
        let downloadPromises = urls.map { url in
            return Promise<PhotoModel> { seal in
                guard let photoUrl = URL(string: url.url),
                      let photoData = try? Data(contentsOf: photoUrl),
                      let photoImage = UIImage(data: photoData) else {
                    seal.reject(ApplicationError.invalidPhotoURL)
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let photoModel = PhotoModel(photo: url, image: photoImage)
                    self.photos.append(photoModel)
                    self.isLoading = false
                    seal.fulfill(photoModel)
                }
            }
        }
        return when(fulfilled: downloadPromises)
    }
    
    /// Fetches and downloads photos asynchronously. Updates the `photos` array and `isLoading` flag accordingly.
    func fetchAndDownloadPhotos() {
        firstly {
            fetchPhotos()
        }
        .then(on: DispatchQueue.global(qos: .background)) { photos in
            self.downloadPhotos(urls: photos)
        }
        .done { images in
            self.photos = images
            self.isLoading = false
        }
        .catch { error in
            print("Error: \(error.localizedDescription)")
            self.isLoading = false
        }
    }
}

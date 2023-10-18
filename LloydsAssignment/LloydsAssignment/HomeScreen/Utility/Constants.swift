//
//  Constants.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import Foundation

/// A struct containing constant values used throughout the application.
struct Constants {
    
    /// A nested struct containing padding sizes used for layout spacing.
    struct Paddings {
        /// The padding size of 200 points.
        static let size200 = 200.0
        /// The padding size of 10 points.
        static let size10 = 10.0
    }
    
    /// A nested struct containing string constants used in the application.
    struct String {
        /// The default title used in the application, "Photos".
        static let title = "Photos"
        static let albumID = "Album ID: "
    }
    
    /// A nested struct containing URL paths used for network requests.
    struct URLPath {
        /// The URL path for fetching photos from a remote server.
        static let photosURL = "https://jsonplaceholder.typicode.com/albums/1/photos"
    }
}

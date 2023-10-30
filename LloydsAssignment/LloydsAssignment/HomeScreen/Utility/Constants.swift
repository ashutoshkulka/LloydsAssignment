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
        /// The padding size of 100 points.
        static let size100 = 100.0
        /// The padding sixe og 2 points.
        static let size2 = 2
        /// The padding size of 300 points.
        static let size300 = 300.0
        /// The padding size of 15 points.
        static let size15 = 15.0
        /// The padding size of 20 points.
        static let size20 = 20.0
    }
    
    /// A nested struct containing string constants used in the application.
    struct String {
        /// The default title used in the application, "Photos".
        static let title = "Photos"
        /// The message to display when prompting the user to try the operation again.
        static let tryAgain = "Try again"
        /// The generic error message to display when something goes wrong.
        static let errorMessage = "Some thing went wrong!"
        /// A message to display when no data is available.
        static let noData = "No data...."
        /// A message to display when loading data.
        static let loading = "Loading...."
        /// A message to display when fetching data, such as cat information.
        static let gettingData = "Getting the cats ..."
    }
    
    /// A nested struct containing URL paths used for network requests.
    struct URLPath {
        /// The URL path for fetching photos from a remote server.
        static let photosURL = "https://fakerapi.it/api/v1/images?_quantity9&_type=kittens&_height=300"
    }
}

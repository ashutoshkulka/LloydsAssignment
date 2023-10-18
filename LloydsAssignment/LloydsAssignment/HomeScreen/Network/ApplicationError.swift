//
//  ApplicationError.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

/// Enumeration representing errors that can occur within the application.
enum ApplicationError: Error {
    /// Error indicating that the provided photo URL is invalid or inaccessible.
    case invalidPhotoURL
    /// Error indicating that there are no photos available, or the requested photo list is empty.
    case noPhotos
    /// Error indicating that the received photo data is invalid or cannot be processed.
    case invalidPhotData
}

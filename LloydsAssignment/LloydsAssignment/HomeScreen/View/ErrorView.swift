//
//  ErrorView.swift
//  ErrorView
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI

/// A view displayed when an error occurs in the app.
struct ErrorView: View {
    /// The error message to be displayed.
    var errorMessage: String
    /// A closure to be executed when the user taps the "Try Again" button.
    var onRetry: () -> Void
    /// The body of the view, describing the layout and behavior.
    var body: some View {
        VStack(spacing:Constants.Paddings.size10) {
            Text(Constants.String.errorMessage)
            Text(errorMessage)
            Button(action: {
                onRetry()
            }) {
                Text(Constants.String.tryAgain)
            }
        }
    }
}

/// A preview provider for the ErrorView struct.
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: Constants.String.errorMessage) {
            //Empty Implimetaion
        }
    }
}

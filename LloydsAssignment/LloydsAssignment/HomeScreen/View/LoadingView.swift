//
//  LoadingView.swift
//  LoadingView
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI

/// A view displaying a loading indicator along with loading messages.
struct LoadingView: View {
    var body: some View {
        VStack(spacing: Constants.Paddings.size20)  {
            Text(Constants.String.loading)
            ProgressView()
            Text(Constants.String.gettingData)
                .foregroundColor(.gray)
        }
    }
}

/// A preview provider for the LoadingView struct.
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

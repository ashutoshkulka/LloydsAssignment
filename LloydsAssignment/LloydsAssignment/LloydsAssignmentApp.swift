//
//  LloydsAssignmentApp.swift
//  LloydsAssignment
//
//  Created by Ashutosh Kulkarni.
//

import SwiftUI

@main
struct LloydsAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            let service = APIService()
            let fetchKittensInteractor = FetchKittensInteractor(repository: service)
            let homeViewModel = HomeViewModel(fetchKittensUseCase: fetchKittensInteractor)
            HomeView(homeViewModel: homeViewModel)
        }
    }
}

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
            let service = RemoteService()
            let fetchKittensUseCase = FetchKittensUseCase(repository: service)
            let homeViewModel = HomeViewModel(fetchKittensUseCase: fetchKittensUseCase)
            HomeView(homeViewModel: homeViewModel)
        }
    }
}

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
            let mapper = KittenResponseToDomainDataListMapper()
            let fetchKittensUseCase = FetchKittensUseCase(repository: service,
                                                          mapper: mapper)
            let homeViewModel = HomeViewModel(fetchKittensUseCase: fetchKittensUseCase)
            HomeView(homeViewModel: homeViewModel)
        }
    }
}

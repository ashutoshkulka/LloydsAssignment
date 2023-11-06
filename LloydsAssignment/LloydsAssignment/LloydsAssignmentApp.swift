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
            let repository = Repository(service: service, mapper: mapper)
            let fetchKittensUseCase = FetchKittensUseCase(repository: repository)
            let homeViewModel = HomeViewModel(fetchKittensUseCase: fetchKittensUseCase)
            HomeView(homeViewModel: homeViewModel)
        }
    }
}

//
//  PokemonApp.swift
//  Pokemon
//
//

import SwiftUI
import Kingfisher

class AppDelegate: NSObject, UIApplicationDelegate {
    private let authenticationChallengeResponder =  AuthenticationChallengeResponder()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions
                     : [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        KingfisherManager.shared.downloader.trustedHosts?.insert("raw.githubusercontent.com")
        KingfisherManager.shared.downloader.authenticationChallengeResponder = authenticationChallengeResponder
        return true
    }
}

@main
struct PokemonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

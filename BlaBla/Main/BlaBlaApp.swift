//
//  BlaBlaApp.swift
//  Created by GaliSrikanth on 06/05/25.

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BlaBlaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AuthViewModel()
    @State private var isUserLoggedIn: Bool? = nil
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let isUserLoggedIn = isUserLoggedIn {
                    if isUserLoggedIn {
                        DashboardView()
                            .environmentObject(viewModel)
                    } else {
                        LoginView()
                            .environmentObject(viewModel)
                    }
                } else {
                    ProgressView()
                        .onAppear {
                            Task {
                                self.isUserLoggedIn = await viewModel.checkIfUserLoggedIn()
                            }
                        }
                }
            }
        }
    }
}

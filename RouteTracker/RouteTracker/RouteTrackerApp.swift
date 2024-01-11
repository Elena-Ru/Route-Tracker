//
//  RouteTrackerApp.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI
import SwiftData

@main
struct RouteTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isLogin") {
                MainViewBuilder().toPresent()
            } else {
                LoginViewBuilder().toPresent()
            }
        }
    }
}

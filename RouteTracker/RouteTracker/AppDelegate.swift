//
//  AppDelegate.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path),
           let apiKey = config[Constants.apiKey] as? String {
            GMSServices.provideAPIKey(apiKey)
        } else {
            fatalError("Failed to load the API key from Config.plist")
        }
        return true
    }
}

// MARK: - Constants
private extension AppDelegate {
    enum Constants {
        static let apiKey: String = "GoogleMapsAPIKey"
    }
}

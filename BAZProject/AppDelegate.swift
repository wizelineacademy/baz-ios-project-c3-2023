//
//  AppDelegate.swift
//  BAZProject
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Create an instance of your custom view controller
        let initialViewController = MovieHubRouter.createModule()
        // Create a UIWindow and set the root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}


//
//  AppDelegate.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)

        let tabbarController = TabbarController()
        window?.rootViewController = UINavigationController(
            rootViewController: tabbarController
        )

        window?.makeKeyAndVisible()
        return true
    }

}


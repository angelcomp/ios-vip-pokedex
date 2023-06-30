//
//  AppDelegate.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
    
        return true
    }

}


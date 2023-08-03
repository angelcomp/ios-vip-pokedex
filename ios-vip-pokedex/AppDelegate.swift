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
        window?.makeKeyAndVisible()
        
        let home = HomeViewController()
        let navigation = UINavigationController(rootViewController: home)
        
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigation
    
        return true
    }

}


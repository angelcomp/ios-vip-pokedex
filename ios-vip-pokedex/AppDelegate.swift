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
        
        let home = PokedexViewController()
        let homeNavigation = UINavigationController(rootViewController: home)
        
        let berries = BerriesViewController()
        let berriesNavigation = UINavigationController(rootViewController: berries)
        
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = .black
        
        home.tabBarItem = UITabBarItem(title: "Pokémons", image: UIImage(systemName: "pawprint"), selectedImage: UIImage(named: "pawprint.fill"))
        berries.tabBarItem = UITabBarItem(title: "Berries", image: UIImage(systemName: "leaf"), selectedImage: UIImage(named: "leaf.fill"))
        
        tabBar.viewControllers = [homeNavigation, berriesNavigation]
        
        window?.backgroundColor = .systemBackground
        window?.rootViewController = tabBar
    
        return true
    }

}


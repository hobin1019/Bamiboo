//
//  AppDelegate.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // init window
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = MainViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}


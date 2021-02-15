//
//  AppDelegate.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .dark
        }
        let splashVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
        self.window?.rootViewController = splashVC
        self.window?.makeKeyAndVisible()
        

        return true
    }



}


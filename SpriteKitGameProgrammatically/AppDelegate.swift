//
//  AppDelegate.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/18/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let gameViewController = GameViewController()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = gameViewController
        
        ACTManager.shared.launch()
        
        return true
    }

}


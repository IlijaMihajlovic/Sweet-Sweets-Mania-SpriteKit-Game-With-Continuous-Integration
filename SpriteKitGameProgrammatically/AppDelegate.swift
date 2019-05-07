//
//  AppDelegate.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/18/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let gameViewController = GameViewController()
        //let firebaseManager = FirebaseManager()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = gameViewController
        //window?.rootViewController = firebaseManager
        
        ACTManager.shared.launch()
        
        return true
    }

}


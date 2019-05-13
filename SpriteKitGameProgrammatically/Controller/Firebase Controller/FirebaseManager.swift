//
//  FirebaseManager.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import SpriteKit
import FirebaseAuth

class FirebaseManager: SKScene {

    override func didMove(to view: SKView) {
        self.checkLoggedInUserStatus()
        print("In Firebase Manager")

    }
    
    //Check if the user is Siggned Up or Logged in
    fileprivate func checkLoggedInUserStatus() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    
                    SSMManager.shared.transition(self, toScene: .WelcomeScene, transition: SKTransition.moveIn(with: .down, duration: 0.0))
                   
                    return
                }
            }
            
        
        } else if Auth.auth().currentUser != nil {
           
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    
                    SSMManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.0))
                    
                    print("In Main Menu")
                    return
                   
                }
            }
        }
    }
}

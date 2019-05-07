//
//  UserProfileController.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import SpriteKit
import FirebaseAuth
import UIKit

class UserProfileScene: SKScene {
    
    lazy var signOutAnonymouslyButton: BDButton = {
        var button = BDButton(imageNamed: "SignOut", buttonAction: {
            
         self.handleSignOutButtonTapped()
            
        })
        
        button.scaleTo(screenWithPercentage: 0.3)
        button.zPosition = 1
        return button
    }()
    
    lazy var backButton: BDButton = {
        var button = BDButton(imageNamed: "BackToMainMenu", buttonAction: {
            
           ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.1))
            
        })
        button.scaleTo(screenWithPercentage: 0.3)
        button.zPosition = 2
        return button
    }()
    
    
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scene?.backgroundColor = .white
       
        setupNodes()
        addNodes()
        
        print("In UserProfileController")
    }
    
    //Check if the user is Siggned Up
    fileprivate func handleSignOutButtonTapped() {
       
        let errorAction = UIAlertAction(title: "Sign Out Error", style: .default, handler: nil)
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            
            do {
                try Auth.auth().signOut()
              
                ACTManager.shared.transition(self, toScene: .WelcomeScene, transition: SKTransition.moveIn(with: .left, duration: 0.1))
                
            } catch let err {
                print("Failed to sign out with error", err)
                
                ACTManager.shared.showAlert(on: self, title: "Sign Out Error", message: err.localizedDescription, actions: [errorAction], animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ACTManager.shared.showAlert(on: self, title: "Are You Sure?", message: "You Will Sign Out From The Biggest Logo", actions: [cancelAction, signOutAction])
        
    }
    
 
    
    func addNodes() {
        addChild(signOutAnonymouslyButton)
        addChild(backButton)
    }
    
    func setupNodes() {
        //signOutAnonymouslyButton.position = CGPoint(x: ScreenSize.width * 0.20, y: ScreenSize.heigth * -0.15)
        signOutAnonymouslyButton.position = CGPoint(x: ScreenSize.width * 0.31, y: ScreenSize.heigth * 0.40)
        backButton.position = CGPoint(x: ScreenSize.width * -0.29, y: ScreenSize.heigth * 0.40)
        //backButton.position = .zero
    }
}





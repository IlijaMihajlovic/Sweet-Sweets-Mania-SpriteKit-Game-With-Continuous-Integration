//
//  LoginScene.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/23/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//


import SpriteKit

class LoginScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        view.backgroundColor = .red
        print("Login Scene")
    }
    
    func share() {
        SSMManager.shared.share(on: self, text: "I just love this new game. Go ahead and download 'The Biggest Donut' from the App Store", image: UIImage(named: "Donut92"), exculdeActivityTypes: [])
    }
}

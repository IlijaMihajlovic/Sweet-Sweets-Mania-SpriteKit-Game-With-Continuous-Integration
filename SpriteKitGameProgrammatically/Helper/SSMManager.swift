//
//  Sweet Sweets Mania
//  SSMManager.swift
//
//  Created by Ilija Mihajlovic on 4/18/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation
import SpriteKit

class SSMManager {
    
    //Initialize of class private
    private init() {}
    static let shared = SSMManager()
    
    public func launch() {
        firstLaunch()
    }
    
    private func firstLaunch() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            
            print("This is our first launch")
            SSMPlayerStats.shared.setSounds(true)
          
            
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
        }
    }
    
    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil ) {
        guard let scene = getScene(toScene) else { return }
        
        if let transition = transition {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transition)
        } else {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }
        
    }
    
    func getScene(_ sceneType: SceneType) -> SKScene? {
        switch sceneType {
    
        case SceneType.WelcomeScene:
            return WelcomeScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
            
        case SceneType.UserProfileScene:
            return UserProfileScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
     
        case SceneType.MainMenu:
            return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
            
        case SceneType.Gameplay:
            return Gameplay(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
            
        case SceneType.GameOver:
            return GameOver(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
        }
    }
    
    func run(_ fileName: String, onNode: SKNode) {
        if SSMPlayerStats.shared.getSound() {
            onNode.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
        }
    }
    
    func showAlert(on scene: SKScene, title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction], animated: Bool = true, delay: Double = 0.0, completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alert.addAction(action)
        }
        
        let wait = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: wait) {
            scene.view?.window?.rootViewController?.present(alert, animated: animated, completion: completion)
        }
        
    }
    
}




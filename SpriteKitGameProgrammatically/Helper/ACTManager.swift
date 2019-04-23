//
//  ACTManager.swift
//  AdventCalendarTutorials
//
//  Created by Alex Nagy on 04/12/2017.
//  Copyright © 2017 Alex Nagy. All rights reserved.
//

import Foundation
import SpriteKit

class ACTManager {
    
    enum SceneType {
        case MainMenu, Gameplay, GameOver, AboutScene, LoginScene, VolumeScene
    }
    
    //initialize of class private
    private init() {}
    static let shared = ACTManager()
    
    public func launch() {
        firstLaunch()
    }
    
    private func firstLaunch() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            
            print("This is our first launch")
            ACTPlayerStats.shared.setSounds(true)
            ACTPlayerStats.shared.saveMusicVolume(0.9)
            
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
        case SceneType.AboutScene:
            return AboutScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
        
        case SceneType.LoginScene:
            return LoginScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
       
        case SceneType.VolumeScene:
            return VolumeScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
            
            
        case SceneType.MainMenu:
            return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
        case SceneType.Gameplay:
            return Gameplay(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
        case SceneType.GameOver:
            return GameOver(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
        }
    }
    
    func run(_ fileName: String, onNode: SKNode) {
        if ACTPlayerStats.shared.getSound() {
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
    
    func share(on scene: SKScene, text: String, image: UIImage?, exculdeActivityTypes: [UIActivity.ActivityType] ) {
        // text to share
        //let text = "This is some text that I want to share."
        guard let image = image else {return}
        // set up activity view controller
        let shareItems = [ text, image ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = scene.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = exculdeActivityTypes
        
        // present the view controller
        scene.view?.window?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
}



































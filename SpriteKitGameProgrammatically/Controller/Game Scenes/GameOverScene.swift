//
//  GameOverScene.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 4/18/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import SpriteKit
import StoreKit

class GameOverScene: SKScene {
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "BackgroundImage")
        
        sprite.scaleTo(screenWidthPercentage: 1.0)
        sprite.zPosition = 0
        return sprite
    }()
    
    
    lazy var backButton: SSMButton = {
        var button = SSMButton(imageNamed: "ButtonBack", title: "", buttonAction: {
            
            SSMManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.5))
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
    
    lazy var replayButton: SSMButton = {
        var button = SSMButton(imageNamed: "ButtonReplay", buttonAction: {
            
            SSMManager.shared.transition(self, toScene: .Gameplay, transition: SKTransition.moveIn(with: .left, duration: 0.5))
        })
        
        if DeviceType.isiPad{
            //button.scaleTo(screenWithPercentage: 0.22)
        } else {
            button.scaleTo(screenWithPercentage: 0.22)
        }
      
        button.zPosition = 1
        return button
    }()
    
    
    var title: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.fontSize = CGFloat.universalFont(size: 30)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Game Over"
        return label
    }()
    
    
    var score: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.fontSize = CGFloat.universalFont(size: 26)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Score: \(SSMPlayerStats.shared.getScore())"
        return label
    }()
    
    
    var bestScore: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.fontSize = CGFloat.universalFont(size: 26)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Best Score: \(SSMPlayerStats.shared.getBestScore())"
        return label
    }()
    
    
    
    override func didMove(to view: SKView) {
        
        //Ask the user to rate or review the app
        SKStoreReviewController.requestReview()
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addNodes()
        setupNodes()
    }
    
    
    func addNodes() {
        [background, title, score, bestScore ,backButton, replayButton].forEach{(addChild($0))}
    }
    
    
    //MARK: - Constraints
    func setupNodes() {
        background.position = CGPoint.zero
        title.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.28)
        score.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.21)
        bestScore.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.15)
        backButton.position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.heigth * 0.4)
        replayButton.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.heigth * 0.0)
    }
    
}



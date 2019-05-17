//
//  GameplayScene.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 4/18/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var score = 0
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "BackgroundImage")
        if DeviceType.isiPad || DeviceType.isiPadPro {
            sprite.scaleTo(screenWidthPercentage: 1.0)
        } else {
            sprite.scaleTo(screenHeightPercentage: 1.0)
            sprite.scaleTo(screenWidthPercentage: 1.0)
        }
        sprite.zPosition = 0
        return sprite
    }()
    
    lazy var backButton: SSMButton = {
        var button = SSMButton(imageNamed: "ButtonBack", title: "", buttonAction: {
            
            SSMManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.5))
        })
        button.zPosition = 42
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
   
    lazy var scoreLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.fontSize = CGFloat.universalFont(size: 58)
        label.zPosition = 42
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "\(score)"
        return label
    }()
    
    
    override func didMove(to view: SKView) {
        addNodes()
        setupNodes()
        addNewSweets()
    }
    
  
    func startNewBoard() {
        removeAllSweets()
        addNewSweets()
    }
    
    
    func addNewSweets() {
        for i in 1...12 {
            
            let imageNamed = "sweet\(Int(CGFloat.random(1.0, max: 12.0)))"
            
            let sweet = GPButton(imageNamed: imageNamed) {
                print("Wrong Sweet Tapped")
                self.handleWrongSweetTapped()
            }
            sweet.name = "sweet"
            sweet.scaleTo(screenWithPercentage: CGFloat.random(0.2, max: 0.3))
            sweet.zPosition = CGFloat(i)
            sweet.position = CGPoint(x: ScreenSize.width * CGFloat.random(0.1, max: 0.9), y: ScreenSize.heigth * CGFloat.random(0.1, max: 0.9))
            addChild(sweet)
            sweet.button.popUp(after: CGFloat.random(0.1, max: 1.0), sequenceNumber: 0)
        }
        
        let imageNamed = "sweet\(Int(CGFloat.random(1.0, max: 12.0)))"
        let winnerSweet = GPButton(imageNamed: imageNamed) {
            print("Winer Sweet Tapped")
            self.handleWinnerSweetTapped()
        }
        winnerSweet.scaleTo(screenWithPercentage: 0.43)
        winnerSweet.name = "sweet"
        winnerSweet.zPosition = CGFloat(31)
        winnerSweet.position = CGPoint(x: ScreenSize.width * CGFloat.random(0.1, max: 0.9), y: ScreenSize.heigth * CGFloat.random(0.1, max: 0.9))
        addChild(winnerSweet)
        winnerSweet.button.popUp()
    }
    
   
    func removeAllSweets() {
        enumerateChildNodes(withName: "//*") { (node, stop) in
            if node.name == "sweet" {
                node.removeFromParent()
            }
        }
    }
    
   
    func handleWinnerSweetTapped() {
        score += 1
        updateScoreLabel()
        startNewBoard()
    }
    
   
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    
    func handleWrongSweetTapped() {
        SSMPlayerStats.shared.setScore(score)
        SSMManager.shared.transition(self, toScene: .GameOver, transition: SKTransition.moveIn(with: .right, duration: 0.5))
    }
    
    
    func addNodes() {
        [background, scoreLabel, backButton].forEach{(addChild($0))}
    }
    
    //MARK: - Constraints
    func setupNodes() {
        background.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.heigth * 0.5)
        scoreLabel.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.heigth * 0.9)
        backButton.position = CGPoint(x: ScreenSize.width * 0.1, y: ScreenSize.heigth * 0.9)
   
    }
    
}




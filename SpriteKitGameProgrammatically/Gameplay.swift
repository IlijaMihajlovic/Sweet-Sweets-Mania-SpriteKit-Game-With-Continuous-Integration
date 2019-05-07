//
//  Gameplay.swift
//  ACTGame
//
//  Created by Alex Nagy on 21/12/2017.
//  Copyright © 2017 Alex Nagy. All rights reserved.
//

import SpriteKit

class Gameplay: SKScene {
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "Background")
        if DeviceType.isiPad || DeviceType.isiPadPro {
            sprite.scaleTo(screenWidthPercentage: 1.0)
        } else {
            sprite.scaleTo(screenHeightPercentage: 1.0)
        }
        sprite.zPosition = 0
        return sprite
    }()
    
    var score = 0
    
    lazy var scoreLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "GlutenFT-Regular")
        label.fontSize = CGFloat.universalFont(size: 58)
        label.zPosition = 10
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "\(score)"
        return label
    }()
    
    override func didMove(to view: SKView) {
        setupNodes()
        addNodes()
        addNewDonuts()
    }
    
    func setupNodes() {
        background.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.heigth * 0.5)
        scoreLabel.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.heigth * 0.9)
    }
    
    func addNodes() {
        addChild(background)
        addChild(scoreLabel)
    }
    
    func startNewBoard() {
        removeAllDonuts()
        addNewDonuts()
    }
    
    func addNewDonuts() {
        for i in 1...30 {
            
            let imageNamed = "Donut\(Int(CGFloat.random(1.0, max: 2.0)))"
            
            let donut = BDButton(imageNamed: imageNamed) {
                print("Wrong Donut tapped")
                self.handleWrongDonutTapped()
            }
            donut.name = "donut"
            donut.scaleTo(screenWithPercentage: CGFloat.random(0.3, max: 0.5))
            donut.zPosition = CGFloat(i)
            donut.position = CGPoint(x: ScreenSize.width * CGFloat.random(0.1, max: 0.9), y: ScreenSize.heigth * CGFloat.random(0.1, max: 0.9))
            addChild(donut)
            donut.button.popUp(after: CGFloat.random(0.1, max: 1.0), sequenceNumber: 0)
        }
        
        let imageNamed = "Donut\(Int(CGFloat.random(1.0, max: 96.0)))"
        let winnerDonut = BDButton(imageNamed: imageNamed) {
            print("Winner Donut tapped")
            self.handleWinnerDonutTapped()
        }
        winnerDonut.scaleTo(screenWithPercentage: 0.51)
        winnerDonut.name = "donut"
        winnerDonut.zPosition = CGFloat(31)
        winnerDonut.position = CGPoint(x: ScreenSize.width * CGFloat.random(0.1, max: 0.9), y: ScreenSize.heigth * CGFloat.random(0.1, max: 0.9))
        addChild(winnerDonut)
        winnerDonut.button.popUp()
    }
    
    func removeAllDonuts() {
        enumerateChildNodes(withName: "//*") { (node, stop) in
            if node.name == "donut" {
                node.removeFromParent()
            }
        }
    }
    
    func handleWinnerDonutTapped() {
        score += 1
        updateScoreLabel()
        startNewBoard()
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    func handleWrongDonutTapped() {
        ACTPlayerStats.shared.setScore(score)
        ACTManager.shared.transition(self, toScene: .GameOver, transition: SKTransition.moveIn(with: .right, duration: 0.5))
    }
}

























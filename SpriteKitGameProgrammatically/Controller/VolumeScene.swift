//
//  VolumeScene.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/23/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import SpriteKit

class VolumeScene: SKScene {
    
    var volumeLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 1
        label.text = "\(Int(ACTPlayerStats.shared.getMusicVolume() * 100))%"
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        return label
    }()
    
    lazy var minusVolumeButton: BDButton = {
        
        var button = BDButton(imageNamed: "ButtonVolume", title: "-", buttonAction: {
            self.handleMinusVolumeButton()
        })
        button.zPosition = 1
        button.titleLabel?.fontSize = CGFloat.universalFont(size: 28)
        button.scaleTo(screenWithPercentage: 0.12)
        return button
    }()
    
    
    lazy var plusVolumeButton: BDButton = {
        
        var button = BDButton(imageNamed: "ButtonVolume", title: "+", buttonAction: {
            self.handlePlusVolumeButton()
        })
        button.zPosition = 1
        button.titleLabel?.fontSize = CGFloat.universalFont(size: 28)
        button.scaleTo(screenWithPercentage: 0.12)
        return button
    }()
    
    func handlePlusVolumeButton() {
        setMusicBackground(by: 0.10)
    }
    
    func handleMinusVolumeButton() {
        setMusicBackground(by: -0.10)
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene?.backgroundColor = SKColor.orange
        print("Volume Scene")
        
        volumeLabel.position = CGPoint.zero
        addChild(volumeLabel)
        
        minusVolumeButton.position = CGPoint(x: ScreenSize.width * -0.2, y: ScreenSize.heigth * 0.0)
        addChild(minusVolumeButton)
        
        plusVolumeButton.position = CGPoint(x: ScreenSize.width * 0.2, y: ScreenSize.heigth * 0.0)
        addChild(plusVolumeButton)
    }
    
    
    func setMusicBackground(by volume: Float) {
    
        let currentVolume = ACTPlayerStats.shared.getMusicVolume()
        
        var volume = currentVolume + volume
        if volume >= 1.0 {
            volume = 1.0
        }
        if volume <= 0.0 {
            volume = 0.0
        }
        
        //Getting the volume level as a percent number by multiplying it with 100(hundred)
        volumeLabel.text = "\(Int(volume * 100))%"
        
        ACTPlayerStats.shared.saveMusicVolume(volume)
        
        let info = ["volume": ACTPlayerStats.shared.getMusicVolume()]
        
        //Informing the GameViewController through a notification that we want to set the volume
        NotificationCenter.default.post(name: setMusicVolumeNotificationName, object: nil, userInfo: info)
    }
    
}

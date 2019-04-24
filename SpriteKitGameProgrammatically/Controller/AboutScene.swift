//
//  AboutScene.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/23/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//


import SpriteKit
import UIKit

class AboutScene: SKScene {
    
    private var customToolBar: UIImageView = {
        var cv = UIImageView(image: UIImage(named: "Donut72"))
        cv.layer.zPosition = 4
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var backButton: BDButton = {
        var button = BDButton(imageNamed: "ButtonBack", title: "", buttonAction: {
            ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
           self.labelTextView.removeFromSuperview()
            self.customToolBar.removeFromSuperview()
           
            
        
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
    var imageNode: SKShapeNode = {
        var image = SKShapeNode(circleOfRadius: 70)
        image.fillTexture = SKTexture(image: UIImage(named: "Moja")!)
        image.lineWidth = 3
        image.fillColor = .white
        
        return image
    }()
    
    var labelNode: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        label.fontSize = 18
        label.text = """
        Self-taught iOS developer/engineer and computer science graduate, with a passion for machine learning and computer vision.
        I specialize mainly in iOS development (iPhone, iPad) but lately, I'm working on python and machine learning too. In my free time, I read about deep learning, neural nets and their application towards solving difficult and data-intensive problems or just playing with the nearest dog. If you want to get in touch and by the way, you know a  good joke you can contact me by email or message me over Linkedin.
        """
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 310
        label.fontColor = SKColor.white
        label.zPosition = 3

        return label
    }()
    
    //Using UITextView over SKLabelNode because of alignment issues
    var labelTextView: UITextView = {
        var label = UITextView()
        label.text = """
        
        Self-taught iOS developer/engineer and computer science graduate, with a passion for machine learning and computer vision.
        I specialize mainly in iOS development (iPhone, iPad) but lately, I'm working on python and machine learning too. In my free time, I read about deep learning, neural nets and their application towards solving difficult and data-intensive problems or just playing with the nearest dog. If you want to get in touch and by the way, you know a  good joke you can contact me by email or message me over Linkedin.
        """
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.backgroundColor = UIColor.clear
        label.autocapitalizationType = UITextAutocapitalizationType.words
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 4
        
        return label
    }()
    
    

    
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        print("About Scene")
        
        view.addSubview(customToolBar)
        
        UIView.animate(withDuration: 30, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            view.addSubview(self.labelTextView)
        })
     
        setupNodes()
        
    
        
        addNodes()
        
      
        
        
    }
    

    
    func setupNodes() {
        //labelNode.position = CGPoint(x: ScreenSize.width * -0.04, y: ScreenSize.heigth * -0.40)
        imageNode.position = CGPoint(x: ScreenSize.width * -0.0, y: ScreenSize.heigth * 0.3)
        
        backButton.position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.heigth * 0.4)
    
        customToolBar.anchor(top: view?.topAnchor, bottom: nil, leading: nil, trailing: view?.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 5), size: .init(width: 70, height: 50))
        
        labelTextView.anchor(top: view?.topAnchor, bottom: view?.bottomAnchor, leading: view?.leadingAnchor, trailing: view?.trailingAnchor, padding: .init(top: 210, left: 3, bottom: 0, right: 3))
        
    }
    
    func addNodes() {
        
    
        
        addChild(imageNode)
        addChild(backButton)
        //addChild(labelNode)
        
        
    }
    
   
    
}




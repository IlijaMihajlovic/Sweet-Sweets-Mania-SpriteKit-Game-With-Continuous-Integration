//
//  TestVC.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import SpriteKit

class TestVC: UIViewController {
    
    
    
    private var buttonTapped: UIButton = {
        var button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitle("Test Button", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressMenuButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func pressMenuButtonAction(_ sender: UIButton!) {
        print("Button Tappped")

        
        self.dismiss(animated: true, completion: nil)
//         let scene = MainMenu()
//
//        let skView = view as! SKView
//
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .aspectFill
//
//
//
//        skView.presentScene(scene, transition: .push(with: .left, duration: 0.2))

    }
    


   
//    override func loadView() {
//        self.view = SKView()
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view = SKView()
    
     
         view.addSubview(buttonTapped)
        buttonTapped.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonTapped.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       

       self.view.backgroundColor = .red
        print("TEST VC")
////        if let view = self.view as? GameView
////        {
////            view.delegate = self
////        }
//        
//        if (self.view as! SKView?) != nil {
//            
//            self.scene = AboutScene(fileNamed: "AboutScene")
//        }
//        
//        self.scene?.gameDelegate = self
//    }
    }

}

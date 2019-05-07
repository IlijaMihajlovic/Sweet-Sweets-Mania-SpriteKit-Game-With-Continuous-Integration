//
//  WelcomeViewController.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//import LBTAComponents
//import JGProgressHUD
//
//class WelcomeController: UIViewController {
//
//    let hud: JGProgressHUD = {
//        let hud = JGProgressHUD(style: .light)
//        hud.interactionType = .blockAllTouches
//        return hud
//    }()
//
//    lazy var signInAnonymouslyButton: UIButton = {
//
//        var button = UIButton(type: .system)
//        button.setTitle("Sign Up Anonymously", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.setTitleColor(Service.buttonTitleColor, for: .normal)
//        button.backgroundColor = Service.buttonBackgroundColorSignInAnonymously
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = Service.buttonCornerRadius
//        //button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(handleSignInAnonymouslyButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    @objc fileprivate func handleSignInAnonymouslyButtonTapped() {
//        hud.textLabel.text = "Signing In Anonymously..."
//        hud.show(in: view, animated: true)
//        Auth.auth().signInAnonymously { (user, error) in
//            if let err = error {
//                self.hud.dismiss(animated: true)
//                print("errror",err)
//
//                //self.showAlert(on: self, style: .alert, title:"Sign In Error", message: err.localizedDescription)
//                return
//            }
//            print("Sucessfllly signed in Anonymously wiht uidi:", user?.user.uid)
//            self.hud.dismiss(animated: true)
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .orange
//        navigationItem.title = "Welcome"
//        setupViews()
//    }
//
//    fileprivate func setupViews() {
//        view.addSubview(signInAnonymouslyButton)
//
//        signInAnonymouslyButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 50, heightConstant: 50)
//    }
//
//
//
//}


import SpriteKit
import FirebaseAuth

class WelcomeScene: SKScene {
    
    lazy var signInAnonymouslyButton: BDButton = {
        var button = BDButton(imageNamed: "Donut8", buttonAction: {
            
            self.handleSignInAnonymouslyButtonTapped()
            
        })
        button.titleLabel?.text = "Sign Up Anonymously"
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 3
        return button
    }()

    
    
    fileprivate func handleSignInAnonymouslyButtonTapped() {
        
                Auth.auth().signInAnonymously { (user, error) in
                    if let err = error {
                       
                        print("errror",err)
        
                         let errorAction = UIAlertAction(title: "", style: .default, handler: nil)
                        //self.showAlert(on: self, style: .alert, title:"Sign In Error", message: err.localizedDescription)
                        ACTManager.shared.showAlert(on: self, title: "Sign In Error", message: err.localizedDescription, actions: [errorAction])
                        return
                    }
//                    ACTManager.shared.transition(self, toScene: .UserProfileScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
                    
                        ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.5))

                   
                    print("Sucessfllly signed in Anonymously wiht uidi:", user?.user.uid)
                   
                }
            }
    
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupNodes()
        addNodes()
        print("Welcome Controller")
        view.backgroundColor = SKColor.red
    }


    func addNodes() {
        addChild(signInAnonymouslyButton)
    }
    
    func setupNodes() {
        signInAnonymouslyButton.position = CGPoint(x: ScreenSize.width * 0.30, y: ScreenSize.heigth * 0.35)
    }
}

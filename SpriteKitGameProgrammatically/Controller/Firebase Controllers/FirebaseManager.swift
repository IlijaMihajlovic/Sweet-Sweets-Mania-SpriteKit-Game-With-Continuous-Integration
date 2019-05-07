//
//  FirebaseManager.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//import SpriteKit
//
//class FirebaseManager: UIViewController {
//
//    lazy var goToUserProfileButton: UIButton = {
//
//        var button = UIButton(type: .system)
//        button.setTitle("Sign Up Anonymously", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.setTitleColor(Service.buttonTitleColor, for: .normal)
//        button.backgroundColor = Service.buttonBackgroundColorSignInAnonymously
//        //button.layer.masksToBounds = true
//        //button.layer.cornerRadius = Service.buttonCornerRadius
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(handleSignInAnonymouslyButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//
//    @objc fileprivate func handleSignInAnonymouslyButtonTapped() {
//        let userProfile = UserProfileController()
//
//     present(userProfile, animated: true, completion: nil)
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .purple
//        addSubView()
//        addConstraints()
//        checkLoggedInUserStatus()
//
//    }
//
//    //Check if the user is Siggned Up
//    fileprivate func checkLoggedInUserStatus() {
//
//        if Auth.auth().currentUser == nil {
//            DispatchQueue.main.async {
//                DispatchQueue.main.async {
//
//                    let welcomeController = WelcomeController()
//                    self.present(welcomeController, animated: true, completion: nil)
//
//
//
//                    return
//                }
//            }
//        }
//    }
//
//    fileprivate func addSubView() {
//        [goToUserProfileButton].forEach{(view.addSubview($0))}
//    }
//
//    fileprivate func addConstraints() {
//        goToUserProfileButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, size: .init(width: 80, height: 50))
//
//
//    }
//}

import SpriteKit
import FirebaseAuth

class FirebaseManager: SKScene {

    override func didMove(to view: SKView) {
        self.checkLoggedInUserStatus()
        print("In Firebase Manager")

    }
    
    //Check if the user is Siggned Up or Logged in
    fileprivate func checkLoggedInUserStatus() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    
                    ACTManager.shared.transition(self, toScene: .WelcomeScene, transition: SKTransition.moveIn(with: .down, duration: 0.0))
                   
                    return
                }
            }
            
        
        } else if Auth.auth().currentUser != nil {
           
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    
                    ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.0))
  
//                      ACTManager.shared.transition(self, toScene: .UserProfileScene, transition: SKTransition.moveIn(with: .right, duration: 0.0))
                    
                    print("In Main Menu")
                    return
                   
                }
            }
        }
    }
}

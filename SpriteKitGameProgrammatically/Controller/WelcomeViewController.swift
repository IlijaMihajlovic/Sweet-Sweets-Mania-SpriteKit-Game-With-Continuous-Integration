//
//  WelcomeViewController.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import FirebaseAuth
import LBTAComponents
import JGProgressHUD

class WelcomeController: UIViewController {
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    lazy var signInAnonymouslyButton: UIButton = {
        
        var button = UIButton(type: .system)
        button.setTitle("Sign Up Anonymously", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(Service.buttonTitleColor, for: .normal)
        button.backgroundColor = Service.buttonBackgroundColorSignInAnonymously
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Service.buttonCornerRadius
        //button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignInAnonymouslyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleSignInAnonymouslyButtonTapped() {
        hud.textLabel.text = "Signing In Anonymously..."
        hud.show(in: view, animated: true)
        Auth.auth().signInAnonymously { (user, error) in
            if let err = error {
                self.hud.dismiss(animated: true)
                print("errror",err)
                
                self.showAlert(on: self, style: .alert, title:"Sign In Error", message: err.localizedDescription)
                return
            }
            print("Sucessfllly signed in Anonymously wiht uidi:", user?.user.uid)
            self.hud.dismiss(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        navigationItem.title = "Welcome"
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(signInAnonymouslyButton)
        
        signInAnonymouslyButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 50, heightConstant: 50)
    }
    
    
    
}

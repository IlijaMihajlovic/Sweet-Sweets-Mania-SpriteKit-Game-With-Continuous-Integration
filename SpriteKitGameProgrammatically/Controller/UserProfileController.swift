//
//  UserProfileController.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserProfileController: UIViewController {
    
    lazy var signOutAnonymouslyButton: UIButton = {
        
        var button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(Service.buttonTitleColor, for: .normal)
        button.backgroundColor = Service.buttonBackgroundColorSignInAnonymously
        //button.layer.masksToBounds = true
        //button.layer.cornerRadius = Service.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addSubView()
        setupConstraints()

}

    @objc fileprivate func handleSignOutButtonTapped() {
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            
            do {
                try Auth.auth().signOut()
                
                let welcomeController = WelcomeController()
                
                self.present(welcomeController, animated: true, completion: nil)
                
            } catch let err {
                print("Failed to sign out with error", err)
                self.showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
          
            }

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
    }
    
    fileprivate func setupConstraints() {
        signOutAnonymouslyButton.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 70, height: 70))
    }
    
    fileprivate func addSubView() {
        [signOutAnonymouslyButton].forEach{(view.addSubview($0))}
    }
        
}

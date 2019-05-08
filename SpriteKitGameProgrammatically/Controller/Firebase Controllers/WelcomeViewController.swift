//
//  WelcomeViewController.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/5/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import SpriteKit
import FirebaseAuth
import FacebookCore
import FacebookLogin
import SVProgressHUD

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

    lazy var signInWithFacebookButton: BDButton = {
        var button = BDButton(imageNamed: "Donut19", buttonAction: {
            
            self.handleSignInWithFacebookButtonTapped()
            
        })
        button.titleLabel?.text = "Login With Facebook"
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 3
        return button
    }()
    
    
    fileprivate func handleSignInWithFacebookButtonTapped() {
        
        print("logging in with facebook...")
     
        //SVProgressHUD.show(withStatus: "Logging in with Facebook...")
     
        
     
        //SVProgressHUD.showError(withStatus: "Error \n ghghghg")
        let login = LoginManager()
       
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        login.logIn(readPermissions: [.publicProfile, .email], viewController: viewController) { (result) in
            
            switch result {
            
            case . success(grantedPermissions: _, declinedPermissions: _, token: _):
                
                print("Sucessfully logged into Facebook")
                
                SVProgressHUD.show(withStatus: "Logging In With Facebook")
                self.signInIntoFirebase()
                
            case .failed(let err):
                print(err)
                SVProgressHUD.showError(withStatus: "Fialded to Get Facebook User\n \(err)")
            case .cancelled:
                SVProgressHUD.showError(withStatus: "Canceled Getting Facebook User!")
                print("canceld")
            }
            
           
        }
    }
    
    func signInIntoFirebase() {
        guard let authenticationToken = AccessToken.current?.authenticationToken else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: "Sign Up Error\n \(err)")
                print(err)
                return
            }
            print("Sucessfully authenticated with Firebase")
            //SVProgressHUD.dismiss(withDelay: 0.7)
        } 
    }
    
    fileprivate func handleSignInAnonymouslyButtonTapped() {
        
                Auth.auth().signInAnonymously { (user, error) in
                    if let err = error {
                        print("errror",err)
                       
                         let errorAction = UIAlertAction(title: "", style: .default, handler: nil)
                    
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
        addChild(signInWithFacebookButton)
    }
    
    func setupNodes() {
        signInAnonymouslyButton.position = CGPoint(x: ScreenSize.width * 0.30, y: ScreenSize.heigth * 0.35)
        signInWithFacebookButton.position = .zero
    }
}

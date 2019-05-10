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
import SwiftyJSON
import FirebaseStorage
import FirebaseDatabase
import Kingfisher

class WelcomeScene: SKScene {
    
    var firstName: String?
    var email: String?
    var profileImage: UIImage?
    
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
    
    
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupNodes()
        addNodes()
        print("Welcome Controller")
    }
    
    
    //MARK: Sign In Into Facebook Function
    fileprivate func handleSignInWithFacebookButtonTapped() {
        
        print("Logging in with Facebook...")
     
        let login = LoginManager()
       
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        login.logIn(readPermissions: [.publicProfile, .email], viewController: viewController) { (result) in
            
            switch result {
            
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                
                print("Sucessfully Logged Into Facebook")
                
                SVProgressHUD.show(withStatus: "Logging In With Facebook...")
               
                self.signInIntoFirebase()
                 ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.0))
                SVProgressHUD.dismiss(withDelay: 0.8)
                
            case .failed(let err):
                print(err)
                SVProgressHUD.showError(withStatus: "Failed to Get Facebook User\n \(err)")
                
            case .cancelled:
                SVProgressHUD.showError(withStatus: "Canceled Getting Facebook User!")
               
            }

        }
    }
    
    
    //MARK: - Sign In Into Firebase
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
            
            //Fetch User Data From Facebook
            self.fetchFacebookUser()
        } 
    }
    
    
    //MARK: - Fetch Facebook User
    fileprivate func fetchFacebookUser() {
       
        let graphRequestConnection = GraphRequestConnection()
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, email, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
    
        graphRequestConnection.add(graphRequest) { (httpResponse, result) in
            
            switch result {
            case .success(response: let response):
                guard let responseDictionary = response.dictionaryValue else { return }
                
                
                let json = JSON(responseDictionary)
                
                //Extract: Email,  First Name and Picture URL
                self.firstName = json["first_name"].string
                
                self.email = json["email"].string
                print("User: \(String(describing: self.firstName)), Email: \(String(describing: self.email))")
                
                guard let profilePictureUrl = json["picture"]["data"]["url"].string else { return }
                guard let url = URL(string: profilePictureUrl) else { return }
               
                //Fetch Data
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
                    if let error = err {
                        print(error)
                        return
                    }
                    
                    //Assign fetched image to profile picture variable
                    guard let data = data else { return }
                    self.profileImage = UIImage(data: data)
                    self.saveUserIntoFirebaseStorageAndIntoDatabase()
                    
                }).resume()
                break
                
            case .failed(let err):
                print(err)
                break
            }
        }
        graphRequestConnection.start()
    }
    
    
    //MARK: - Safe User Into into Firebase Storage And into Realtime Database
    fileprivate func saveUserIntoFirebaseStorageAndIntoDatabase() {
        
        let imageUuid = UUID().uuidString
        guard let uploadData = profileImage?.jpegData(compressionQuality: 0.3) else { return }
        
       
        //MARK: - Firebase Storage
        //Safe user profile image to Firebase Storage
        Storage.storage().reference().child("profileImages").child(imageUuid).putData(uploadData, metadata: nil, completion: {(metadata, err) in
            
            if let error = err {
                print("Failed to upload profile image:", error)
                SVProgressHUD.showError(withStatus: "Error\n \(error)")
                return
            }
       
            
        Storage.storage().reference().child("profileImages").child(imageUuid).downloadURL(completion: { (url, err) in
            if let err = err {
                print("Failed to get downloadURL", err)
                return
            }
            guard let profileImageURL = url?.absoluteString else {return}
            print("Successfully uploaded profile image", profileImageURL)
        
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            // Dictionary of keys to change and their new values
            let dictionaryValues = ["name": self.firstName, "email": self.email, "profileImageUrl": profileImageURL]
            
            let values = [uid: dictionaryValues]
            
            
            //MARK: - Firebase Realtime Database
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, refrence) in
                
                if let error = err {
                    print(error)
                    return
                }
                print("Sucessfully saved user info into Firebase Database")
                SVProgressHUD.dismiss()
               

            })
            })
        
        })
    }
    
 
    //MARK: - Sign In Anonymously Function
    fileprivate func handleSignInAnonymouslyButtonTapped() {
        
                Auth.auth().signInAnonymously { (user, error) in
                    if let err = error {
                        print("errror",err)
                       
                         let errorAction = UIAlertAction(title: "", style: .default, handler: nil)
                    
                        ACTManager.shared.showAlert(on: self, title: "Sign In Error", message: err.localizedDescription, actions: [errorAction])
                        return
                    }
                        SVProgressHUD.show(withStatus: "Signing Up Anonymously...")
                    
                    ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.5))
                    SVProgressHUD.dismiss(withDelay: 0.8)
                }
            }
    


    func addNodes() {
        [signInAnonymouslyButton, signInWithFacebookButton].forEach{addChild($0)}
    }
    
    func setupNodes() {
        signInAnonymouslyButton.position = CGPoint(x: ScreenSize.width * 0.30, y: ScreenSize.heigth * 0.35)
        signInWithFacebookButton.position = .zero
    }
}

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
    
    var userName: String?
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
    
    
    fileprivate func handleSignInWithFacebookButtonTapped() {
        
        print("logging in with facebook...")
     
        let login = LoginManager()
       
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        login.logIn(readPermissions: [.publicProfile, .email], viewController: viewController) { (result) in
            
            switch result {
            
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                
                print("Sucessfully logged into Facebook")
                
                SVProgressHUD.show(withStatus: "Logging In With Facebook...")
               
                self.signInIntoFirebase()
                 ACTManager.shared.transition(self, toScene: .UserProfileScene, transition: SKTransition.moveIn(with: .left, duration: 0.0))
                
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
            //SVProgressHUD.dismiss(withDelay: 0.1)
            
            //Fetch Users Data From Facebook
            self.fetchFacebookUser()
        } 
    }
    
    fileprivate func fetchFacebookUser() {
        let graphRequestConnection = GraphRequestConnection()
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
    
        graphRequestConnection.add(graphRequest) { (httpResponse, result) in
            
            switch result {
            case .success(response: let response):
                guard let responseDictionary = response.dictionaryValue else { return }
                
                
                let json = JSON(responseDictionary)
                
                //Extract: Email,  Username and Picture URL
                self.userName = json["name"].string
                self.email = json["email"].string
                
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
                    self.saveUserIntoFirebaseStorageAndDatabase()
                    
                }).resume()
                break
                
            case .failed(let err):
                print(err)
                break
            }
        }
        graphRequestConnection.start()
    }
    
    fileprivate func saveUserIntoFirebaseStorageAndDatabase() {
        
        
//        guard let data = profileImage?.jpegData(compressionQuality: 0.3) else {
//            print("SOMTHING WENT WRONG")
//            return
//        }
//        let imageName = UUID().uuidString
//        let imageReference = Storage.storage().reference().child("profileImages").child(imageName)
//
//        imageReference.putData(data, metadata: nil) { (metadata, err) in
//            if let error = err {
//                SVProgressHUD.showError(withStatus: "Error:\n \(error.localizedDescription)")
//                return
//            }
//
//            imageReference.downloadURL(completion: { (url, err) in
//                if let error = err {
//                    SVProgressHUD.showError(withStatus: "Error:\n \(error.localizedDescription)")
//                    return
//                }
//
//                guard let  url = url else {
//
//                    SVProgressHUD.showError(withStatus: "Error)")
//                    return
//                }
//
//
//            })
//        }
        
   
        

    
//        let fileName = UUID().uuidString
//        guard let uploadData = profileImage?.jpegData(compressionQuality: 0.3) else { return }
//
//        //Safe user profile image to Firebase Storage
//    Storage.storage().reference().child("profileImages").child(fileName).putData(uploadData, metadata: nil) { (metadata, error) in
//
//            if let err = error {
//                print(err)
//                return
//            }
//            print("Succesfully saved profile image into Firebase Storage.")
//
//            //MARK - MAYBE AN ERROR IS HERE
//            guard let profilePictureUrl = metadata?.dictionaryRepresentation()["mediaLink"] as? String else { return }
//
//
//            guard let uid = Auth.auth().currentUser?.uid else {return}
//
//            let dictionaryValues = ["name": self.name, "email": self.email, "profilePictureUrl": profilePictureUrl]
//
//            let values = [uid: dictionaryValues]
//
//            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, refrence) in
//
//                if let error = err {
//                    print(error)
//                    return
//                }
//                print("Sucessfully saved user info into Firebase Database")
//                SVProgressHUD.dismiss(withDelay: 0.1)
//
//            })
    
        let fileName = UUID().uuidString
        guard let uploadData = profileImage?.jpegData(compressionQuality: 0.3) else { return }
        
        //Safe user profile image to Firebase Storage
        Storage.storage().reference().child("profileImages").child(fileName).putData(uploadData, metadata: nil, completion: {(metadata, err) in
            
            if let err = err {
                print("failed to upload profile image:", err)
                return
            }
        Storage.storage().reference().child("profileImages").child(fileName).downloadURL(completion: { (url, err) in
            if let err = err {
                print("Failed to get downloadurl", err)
                return
            }
            guard let profileImageURL = url?.absoluteString else {return}
            print("Successfully uploaded profile image", profileImageURL)
        
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            let dictionaryValues = ["name": self.name, "email": self.email, "profilePictureUrl": profileImageURL]
            
            let values = [uid: dictionaryValues]
            
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

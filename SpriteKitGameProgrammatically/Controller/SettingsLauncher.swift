//
//  SettingsLauncher.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/19/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import UIKit
import SpriteKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let blackView = UIView()
    let cellId = "cellId"
    let cellHeight: CGFloat = 60
    var mainMenu: MainMenu?
    
    //Cell Data Source
    let settings: [SettingsModel] = {
        return [SettingsModel(name: "About", imageName: "aboutIcon"),
                SettingsModel(name: "User", imageName: "profileIcon"),
                SettingsModel(name: "Rate", imageName: "rateButton"),
                SettingsModel(name: "Cancel", imageName: "cancelButton")]
    }()
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            //Make Hight of slide menu dinamic
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //Implement an ease out curve
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
           
        }
        
    }
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    //Sett the minumul Speaceing bettween the cells the defualt one is 10pix
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            handleDismiss()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
            
        }) { (_ ) in
            
            //Present scene after completion
            let setting = self.settings[indexPath.item]
            guard let mainMenu = self.mainMenu else {return}
            
            if setting.name != "Cancel" {
           
                switch indexPath.item {
                
                case 0 :
                    self.collectionViewFlowLayoutInitToSwipeController()
               
                case 1:
                    ACTManager.shared.transition(mainMenu, toScene: .UserProfileScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                    
                case 2:
                   self.rateProjectOnGitHub()
             
                default:
                    break
                }
           
            }
            
        }
        
    }
    
    fileprivate func rateProjectOnGitHub() {
        
        //Check out my GitHub repo
        if let url = URL(string: "https://github.com/IlijaMihajlovic") {
            UIApplication.shared.open(url, options: [:], completionHandler: { (result) in
                if result {
                    print("Success")
                } else {
                    print("Failed")
                }
            })
        }
    }
    
    fileprivate func collectionViewFlowLayoutInitToSwipeController() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let sw = SwipingController(collectionViewLayout: layout)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController?.present(sw, animated: true, completion: nil)
    }
    
 
}

//
//  SettingsLauncher.swift
//  Sweet Sweets Mania
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
    
    let blurredView = UIView()
    let cellId = "cellId"
    let cellHeight: CGFloat = 60
    var mainMenu: MainMenuScene?
    
    // Data source cell
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
            
            blurredView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blurredView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blurredView)
            window.addSubview(collectionView)
            
            //Make Hight of slide menu dynamic 
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blurredView.frame = window.frame
            blurredView.alpha = 0
            
            //Implement an ease out curve
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blurredView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
           
        }
        
    }
    
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            self.blurredView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }

    
    //Bring the user to my GitHub repository when the rate button is tapped
     func rateProjectOnGitHub() {
        
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
    
     func collectionViewFlowLayoutInitToSwipeController() {
        
        let layout = UICollectionViewFlowLayout()
        let sw = SwipingController(collectionViewLayout: layout)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        layout.scrollDirection = .horizontal
        appDelegate?.window?.rootViewController?.present(sw, animated: true, completion: nil)
    }
    
 
}




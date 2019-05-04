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



//Model Class
class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        var mainMenu: MainMenu?
    

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let blackView = UIView()
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    //Cell Data Source
    let settings: [Setting] = {
        return [Setting(name: "About", imageName: "aboutIcon"),
                Setting(name: "Replay", imageName: "replayButton"),
                Setting(name: "Share", imageName: "shareButton"),
                Setting(name: "Cancel", imageName: "settingsButton")]
    }()
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
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
                    ACTManager.shared.transition(mainMenu, toScene: .LoginScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                default:
                    break
                }
           
            }
            
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

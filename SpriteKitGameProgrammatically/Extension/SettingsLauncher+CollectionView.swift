//
//  SettingsLauncher.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 5/14/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import SpriteKit

extension SettingsLauncher {
    
    //MARK: - DataSource & Delegate Methods Of UICollectionView
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
    
    //Set the minimum spacing between the cells. The default one is 10 pixels!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blurredView.alpha = 0
            
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
                    SSMManager.shared.transition(mainMenu, toScene: .UserProfileScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                    
                case 2:
                    self.rateProjectOnGitHub()
                    
                default:
                    break
                }
                
            }
            
        }
        
    }
    
}


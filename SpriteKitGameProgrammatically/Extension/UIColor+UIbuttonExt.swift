//
//  ColorExt.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/3/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import SpriteKit

extension UIColor {
    
    static let mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    static let customLightPinkColor = UIColor(red: 242/255, green: 151/255, blue: 187/255, alpha: 1)
    static let customPurpleColor = UIColor(red: 170/255, green: 53/255, blue: 218/255, alpha: 1)
  
}

extension SKColor {
    static let customSKLightPinkColor = SKColor(red: 242/255, green: 151/255, blue: 187/255, alpha: 1)
}

extension UIButton {
    
    func popUpAnimation() {
        self.transform = self.transform.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
             self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)}, completion: nil)
    }
}

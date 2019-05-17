//
//  CGFloatExtension.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 5/14/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension CGFloat {
    static func universalFont(size: CGFloat) -> CGFloat {
        if DeviceType.isiPhone4OrLess {
            return size * 0.6
        }
        
        if DeviceType.isiPhone5 {
            return size * 0.8
        }
        
        if DeviceType.isiPhone6 {
            return size * 1.0
        }
        
        if DeviceType.isiPhone6Plus {
            return size * 1.0
        }
        
        if DeviceType.isiPhoneX {
            return size * 1.0
        }
        
        if DeviceType.isiPad {
            return size * 2.1
        }
        
        if DeviceType.isiPadPro {
            return size * 2.1
        } else {
            return size * 1.0
        }
    }
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(_ min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
    
}


//
//  SettingsControllerModel.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 5/7/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

class SettingsControllerModel: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

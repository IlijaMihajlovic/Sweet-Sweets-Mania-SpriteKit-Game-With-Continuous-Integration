//
//  ScreenSize.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 5/14/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let heigth = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.heigth)
    static let minLength = min(ScreenSize.width, ScreenSize.heigth)
}

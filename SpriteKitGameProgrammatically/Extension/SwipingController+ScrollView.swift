//
//  SwipingController+ScrollView.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 5/3/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension SwipingController {

    //Set dots on page control to represent the right page when scrolled
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
}

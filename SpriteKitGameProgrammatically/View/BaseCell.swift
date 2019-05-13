//
//  BaseCell.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 4/20/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

//Custom Class Where We Override SetupViews And Setting Them Up
class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

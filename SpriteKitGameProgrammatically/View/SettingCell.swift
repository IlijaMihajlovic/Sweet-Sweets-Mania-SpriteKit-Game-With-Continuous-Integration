//
//  SettingCell.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/20/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settingsButton")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        //MARK TO DO:
        nameLabel.anchor(top: self.topAnchor, bottom: nil, leading: iconImageView.trailingAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 70, height: 40))
        
        iconImageView.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nameLabel.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 50, height: 40))
        
      
        
        
    
    }
}

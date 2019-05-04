//
//  SettingCell.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/20/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func sharePressed(cell: BaseCell)
}

class SettingCell: BaseCell {
    
    //Higlight  Cell
    override var isHighlighted: Bool {
        didSet {
            
            print(isHighlighted)
            
            backgroundColor =  isHighlighted ? UIColor.darkGray : UIColor.white
    
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black

            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            
            
         
        }
    }
    
    var delegate: CustomCellDelegate?
    func didTapShare() {
        delegate?.sharePressed(cell: self)
    }
    
    
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shareButton")
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

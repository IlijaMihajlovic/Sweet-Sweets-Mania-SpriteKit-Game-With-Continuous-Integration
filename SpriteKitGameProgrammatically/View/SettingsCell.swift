//
//  SettingsCell.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 4/20/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    var delegate: SettingsCellDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SettingsControllerModel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shareButton")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    func didTapShare() {
        delegate?.sharePressed(cell: self)
    }
    
    
    var setting: SettingsControllerModel? {
        didSet {
            nameLabel.text = setting?.name
            nameLabel.textColor = UIColor.darkGray
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.customLightPinkColor
            }
        }
    }
    
    
    //Higlight  Cell
    override var isHighlighted: Bool {
        didSet {
            
            print(isHighlighted)
            
            backgroundColor =  isHighlighted ? UIColor.customPurpleColor: UIColor.white
    
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray

            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.customLightPinkColor
            
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        addSubView()
        setupConstraints()
    }
    
    
    fileprivate func addSubView() {
        [nameLabel, iconImageView].forEach{(addSubview($0))}
        
    }
    
    //MARK: - Constraints
    fileprivate func setupConstraints() {
       
        //nameLabel Constraint
        nameLabel.anchor(top: self.topAnchor, bottom: nil, leading: iconImageView.trailingAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 70, height: 40))
        
        //iconImageView Constraint
        iconImageView.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nameLabel.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 7), size: .init(width: 35, height: 35))
    }
}

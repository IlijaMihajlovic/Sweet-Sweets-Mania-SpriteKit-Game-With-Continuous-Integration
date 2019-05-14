//
//  PageCell.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 5/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    private var showImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var topImageContainerView: UIView = {
        var ticv = UIView()
        ticv.backgroundColor = .white
        ticv.translatesAutoresizingMaskIntoConstraints = false
        return ticv
    }()
    
    //Present data from the model
    var page: PageControllerModel? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            showImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubView()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func addSubView() {
        [topImageContainerView,descriptionTextView].forEach{(self.addSubview($0))}
        topImageContainerView.addSubview(showImageView)
    }
    
    //MARK: - Constraints
    fileprivate func setupConstraints() {
        
        //topImageContainerView Constraint
        topImageContainerView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        //showImageView Constraint
        showImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        showImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        showImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //descriptionTextView Constraint
        descriptionTextView.anchor(top: topImageContainerView.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: -55, left: 3, bottom: 0, right: 10))
        
    }
    
}

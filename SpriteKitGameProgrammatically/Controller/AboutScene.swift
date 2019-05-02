//
//  AboutScene.swift
//  SpriteKitGameProgrammatically
//
//  Created by Ilija Mihajlovic on 4/23/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class AboutVC: UIViewController {
    
    let bearImageView: UIImageView = {
       var imageView = UIImageView(image: UIImage(named: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private var buttonTapped: UIButton = {
        var button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitle("Test Button", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressMenuButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func pressMenuButtonAction(_ sender: UIButton!) {
        print("Button Tappped")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        view.addSubview(descriptionTextView)
        
        setupBottomControlls()
        setupLayout()
   
       
        self.view.backgroundColor = .white
        view.addSubview(buttonTapped)
        buttonTapped.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonTapped.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
    
    fileprivate func setupBottomControlls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        bottomControlsStackView.axis = .horizontal
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        //enable auto layout
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}



//import SpriteKit
//import UIKit
//
//
//class AboutScene: SKScene {
//
//
//    let testvc = TestVC()
//
//    private var customToolBar: UIImageView = {
//        var cv = UIImageView(image: UIImage(named: "Donut72"))
//        cv.layer.zPosition = 4
//
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        return cv
//    }()
//
//    lazy var backButton: BDButton = {
//        var button = BDButton(imageNamed: "ButtonBack", title: "", buttonAction: {
//            //ACTManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .left, duration: 0.1))
//            let sceneViewVC = self.view?.window?.rootViewController
//            sceneViewVC?.present(self.testvc, animated: true, completion: nil)
//
//            self.labelTextView.removeFromSuperview()
//            self.customToolBar.removeFromSuperview()
//
//
//
//        })
//        button.zPosition = 1
//        button.scaleTo(screenWithPercentage: 0.15)
//        return button
//    }()
//
//    var imageNode: SKShapeNode = {
//        var image = SKShapeNode(circleOfRadius: 70)
//        image.fillTexture = SKTexture(image: UIImage(named: "Moja")!)
//        image.lineWidth = 3
//        image.fillColor = .white
//
//        return image
//    }()
//
//    var labelNode: SKLabelNode = {
//        var label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
//        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
//
//        label.fontSize = 18
//        label.text = """
//        Self-taught iOS developer/engineer and computer science graduate, with a passion for machine learning and computer vision.
//        I specialize mainly in iOS development (iPhone, iPad) but lately, I'm working on python and machine learning too. In my free time, I read about deep learning, neural nets and their application towards solving difficult and data-intensive problems or just playing with the nearest dog. If you want to get in touch and by the way, you know a  good joke you can contact me by email or message me over Linkedin.
//        """
//        label.numberOfLines = 0
//        label.preferredMaxLayoutWidth = 310
//        label.fontColor = SKColor.white
//        label.zPosition = 3
//
//        return label
//    }()
//
//    //Using UITextView over SKLabelNode because of alignment issues
//    var labelTextView: UITextView = {
//        var label = UITextView()
//        label.text = """
//
//        Self-taught iOS developer/engineer and computer science graduate, with a passion for machine learning and computer vision.
//        I specialize mainly in iOS development (iPhone, iPad) but lately, I'm working on python and machine learning too. In my free time, I read about deep learning, neural nets and their application towards solving difficult and data-intensive problems or just playing with the nearest dog. If you want to get in touch and by the way, you know a  good joke you can contact me by email or message me over Linkedin.
//        """
//        label.textAlignment = NSTextAlignment.center
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
//        label.backgroundColor = UIColor.clear
//        label.autocapitalizationType = UITextAutocapitalizationType.words
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.layer.zPosition = 4
//
//        return label
//    }()
//
//
//
//
//
//    override func didMove(to view: SKView) {
//        anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        print("About Scene")
//
//        view.addSubview(customToolBar)
//
//        UIView.animate(withDuration: 30, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//            view.addSubview(self.labelTextView)
//        })
//
//        setupNodes()
//
//
//
//        addNodes()
//
//
//
//
//
//    }
//
//
//
//    func setupNodes() {
//        //labelNode.position = CGPoint(x: ScreenSize.width * -0.04, y: ScreenSize.heigth * -0.40)
//        imageNode.position = CGPoint(x: ScreenSize.width * -0.0, y: ScreenSize.heigth * 0.3)
//
//        backButton.position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.heigth * 0.4)
//
//        customToolBar.anchor(top: view?.topAnchor, bottom: nil, leading: nil, trailing: view?.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 5), size: .init(width: 70, height: 50))
//
//        labelTextView.anchor(top: view?.topAnchor, bottom: view?.bottomAnchor, leading: view?.leadingAnchor, trailing: view?.trailingAnchor, padding: .init(top: 210, left: 3, bottom: 0, right: 3))
//
//    }
//
//    func addNodes() {
//
//
//
//        addChild(imageNode)
//        addChild(backButton)
//        //addChild(labelNode)
//
//
//    }
//
//
//
//}
//
//
//

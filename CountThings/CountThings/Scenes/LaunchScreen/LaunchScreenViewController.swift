//
//  LaunchScreenViewController.swift
//  CountThings
//
//  Created by Danie Romero on 21-10-19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.splashColor
      
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
      
        let fullString = NSMutableAttributedString(string: Constants.Messages.General.navTextFirst)
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = Constants.Images.ic_asset_icon
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: Constants.Messages.General.navTextLast))
        label.attributedText = fullString
        label.alpha = 0
      
        let starAnimationView = AnimationView()
        let starAnimation = Animation.named("avocado")
        starAnimationView.animation = starAnimation
        starAnimationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 400)
        //starAnimationView.center = self.view.center
        starAnimationView.contentMode = .scaleAspectFill
        starAnimationView.animationSpeed = 1
       
        starAnimationView.play { (finished) in
          /// Animation finished
          self.performSegue(withIdentifier: "Main", sender: nil)
        }
      
        UIView.animate(withDuration: 2, animations: {
            label.alpha = 1
        })
      
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(starAnimationView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
      
    }

}

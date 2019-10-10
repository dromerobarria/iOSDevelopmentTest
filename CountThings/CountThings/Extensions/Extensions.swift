//
//  Extensions.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
  
  /// Used for ViewControllers that need to present an alert.
  func alert(message: String, title: String = "CountThings")
  {
    
    let titleString  = title
    var titleMutableString = NSMutableAttributedString()
    titleMutableString = NSMutableAttributedString(string: titleString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(Constants.Sizes.medium))])
    
    let messageString  = message
    var messageMutableString = NSMutableAttributedString()
    messageMutableString = NSMutableAttributedString(string: messageString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(Constants.Sizes.medium))])
    
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.setValue(titleMutableString, forKey: "attributedTitle")
    alertController.setValue(messageMutableString, forKey: "attributedMessage")
    let OKAction = UIAlertAction(title: Constants.Messages.Alert.okLabel, style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

/// Used for ViewControllers that need to present an activity indicator when loading data.
public protocol ActivityIndicatorPresenter
{
  
  /// The activity indicator
  var activityIndicator: UIActivityIndicatorView { get }
  
  /// Show the activity indicator in the view
  func showActivityIndicator()
  
  /// Hide the activity indicator in the view
  func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController
{
  
  func showActivityIndicator()
  {
    
    self.view.isUserInteractionEnabled = false
    
    DispatchQueue.main.async
      {
      
        self.activityIndicator.style = .large
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        self.activityIndicator.layer.cornerRadius = 6
        self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
  }
  
  func hideActivityIndicator()
  {
    
    self.view.isUserInteractionEnabled = true
    
    DispatchQueue.main.async
      {
      self.activityIndicator.stopAnimating()
      self.activityIndicator.removeFromSuperview()
    }
  }
}

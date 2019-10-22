//
//  ProductCell.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
  
  @IBOutlet weak var mainView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var countStepper: UIStepper!
  @IBOutlet weak var counterView: UIView!
  
  var enable: Bool?
  
  var product: Product?{
    willSet(newValue){
      self.product = newValue
    }
    didSet{
      self.configurateCell()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configurateCell(){
    
    self.backgroundColor = .black
    
    self.mainView.backgroundColor = Constants.Colors.backgroundColor
    self.mainView.layer.borderWidth = 1
    self.mainView.layer.borderColor = UIColor.white.cgColor
    self.mainView.layer.cornerRadius = 8
    
    self.counterView.backgroundColor = Constants.Colors.backgroundColor
    self.counterView.layer.borderWidth = 1
    self.counterView.layer.borderColor = UIColor.white.cgColor
    self.counterView.layer.cornerRadius = 8
    
    self.titleLabel.tintColor = .white
    self.titleLabel.text = "🥑 \(product!.name.uppercased())"
    self.countLabel.text = "\(Constants.Messages.General.countText): \(product!.count)"
    self.countStepper.autorepeat = false
    self.countStepper.minimumValue = -100.0
    self.countStepper.maximumValue = 100.0
    
    self.countStepper.value = Double(product!.count)
    self.countStepper.addTarget(self, action: #selector(ProductCell.stepperValueChanged), for: .valueChanged)
    
    if enable!
    {
      self.counterView.isHidden = false
      self.countStepper.isHidden = false
    }else
    {
      self.counterView.isHidden = true
      self.countStepper.isHidden = true
    }
    
  }
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
   
    guard Int(sender.value) > product!.count else {
      let stepperObject:[String: Product] = ["product": product!]
           NotificationCenter.default.post(name: Notification.Name("decreaseValue"), object: nil, userInfo: stepperObject)
      return
    }
    
    let stepperObject:[String: Product] = ["product": product!]
          NotificationCenter.default.post(name: Notification.Name("increaseValue"), object: nil, userInfo: stepperObject)
    
  }
}

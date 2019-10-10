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
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var countStepper: UIStepper!
  
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
    
    self.titleLabel.text = product!.title
    self.countLabel.text = "\(Constants.Messages.General.countText): \(product!.count)"
    self.countStepper.autorepeat = false
    self.countStepper.minimumValue = -100.0
    self.countStepper.maximumValue = 100.0
    self.countStepper.value = Double(product!.count)
    self.countStepper.addTarget(self, action: #selector(ProductCell.stepperValueChanged), for: .valueChanged)
    
    if enable!
    {
      self.countStepper.isHidden = false
    }else
    {
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

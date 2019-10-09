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
    self.countLabel.text = "Total: \(product!.count)"
  }
  
}

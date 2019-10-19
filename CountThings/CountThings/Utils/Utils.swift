//
//  Utils.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import RealmSwift

/// Return the SUM of products
func sumCount() -> Int
{
  let realm = try! Realm()
  let products = realm.objects(Product.self)
  var total = 0
  for product in products
  {
    total = total + product.count
  }
  return total
}

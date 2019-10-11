//
//  Utils.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation

/// Return the SUM of products
func sumCount(products : [Product]) -> Int
{
  let total = products.reduce(0) { $0 + $1.count}
  return total
}

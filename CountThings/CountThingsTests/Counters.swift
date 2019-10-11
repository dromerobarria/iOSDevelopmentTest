//
//  Products.swift
//  CountThingsTests
//
//  Created by Danie Romero on 10/11/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

@testable import CountThings
import XCTest

struct Counters
{
  struct Products
  {
    static let productsASD = Product(title: "ASD", count: 0, id: UUID().uuidString)
    static let productsFGH = Product(title: "FGH", count: 0, id: UUID().uuidString)
  }
}

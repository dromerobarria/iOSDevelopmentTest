//
//  DetailModels.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

enum Detail
{
  // MARK: Use cases
  enum Product
  {
    struct Request
    {
    }
    
    struct Response
    {
      var name: String!
      var count: Int!
    }
   
    struct ViewModel
    {
      var name: String!
      var count: Int!
    }
  }
}

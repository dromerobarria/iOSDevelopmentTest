//
//  MainTableModels.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

enum MainTable
{
   enum ProductSelected
   {
     struct Request
     {
       var name: String?
       var count: Int?
     }
     
     struct Response
     {
     }
    
     struct ViewModel
     {
     }
   }
  
  
  enum Update
  {
    struct Request
    {
      let products : [Product]
      let product : Product
    }
     
    struct Response
    {
      let products : [Product]
    }
    
    struct ViewModel
    {
      let products : [Product]
    }
  }
  
  enum ProductCreate
  {
    struct Request
    {
      let products : [Product]
      var name: String?
    }
    
    struct Response
    {
      let products : [Product]
    }
   
    struct ViewModel
    {
      let products : [Product]
    }
  }
}

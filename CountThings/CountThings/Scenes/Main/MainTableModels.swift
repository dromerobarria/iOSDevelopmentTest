//
//  MainTableModels.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit
import RealmSwift

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
      let product : Product
    }
     
    struct Response
    {
      var isError : Bool
      var message : String
      let products : Results<Product>
    }
    
    struct ViewModel
    {
      var message : String
      let products : Results<Product>
    }
  }
  
  enum ProductCreate
  {
    struct Request
    {
      var name: String?
    }
    
    struct Response
    {
      var isError : Bool
      var message : String
      let products : Results<Product>
    }
   
    struct ViewModel
    {
      var message : String
      let products : Results<Product>
    }
  }
  
  enum CountersRequest
   {
     struct Request
     {
     }
     
     struct Response
     {
       var products : Results<Product>
       var isError : Bool
       var message : String
     }
    
     struct ViewModel
     {
       var products : Results<Product>
       var message : String
     }
   }
}

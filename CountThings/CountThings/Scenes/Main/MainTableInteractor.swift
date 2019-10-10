//
//  MainTableInteractor.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol MainTableBusinessLogic
{
  func requestDetail(request: MainTable.ProductSelected.Request)
  func requestIncrease(request: MainTable.Update.Request)
  func requestDecrease(request: MainTable.Update.Request)
  func requestDelete(request: MainTable.Update.Request)
  func requestCreate(request: MainTable.ProductCreate.Request)
}

protocol MainTableDataStore
{
   var name: String? { get set }
   var count: Int? { get set }
}

class MainTableInteractor: MainTableBusinessLogic, MainTableDataStore
{
  var presenter: MainTablePresentationLogic?
  var worker: MainTableWorker?
  var name: String?
  var count: Int?
  
  func requestDetail(request: MainTable.ProductSelected.Request)
  {
    self.name = request.name
    self.count = request.count
    let response = MainTable.ProductSelected.Response()
    self.presenter?.presentDetail(response: response)
  }
  
  func requestIncrease(request: MainTable.Update.Request)
  {
    let products  = request.products
    products.filter({$0.title == request.product.title}).first!.count = request.product.count + 1
    
    let response = MainTable.Update.Response(products: products)
    self.presenter?.presentIncrease(response: response)
    
    
  }
  
  func requestDecrease(request: MainTable.Update.Request)
  {
    let products  = request.products
    let product   = request.product
    products.filter({$0.title == product.title}).first!.count = product.count - 1
    let response = MainTable.Update.Response(products: products)
    self.presenter?.presentDecrease(response: response)
  }
  
  func requestDelete(request: MainTable.Update.Request)
  {
    var products  = request.products
    let product   = request.product
    
    let index = products.firstIndex {
        return $0.title == product.title
    }
    
    products.remove(at: index!)
    
    let response = MainTable.Update.Response(products: products)
    self.presenter?.presentDelete(response: response)
    
  }
  
  func requestCreate(request: MainTable.ProductCreate.Request)
  {
    var products  = request.products
    let name  = request.name
    
    let newProduct = Product(title: name!, count: 1, id: UUID().uuidString)
    products.append(newProduct)
    
    let response = MainTable.ProductCreate.Response(products: products)
    self.presenter?.presentCreate(response: response)
  }
}

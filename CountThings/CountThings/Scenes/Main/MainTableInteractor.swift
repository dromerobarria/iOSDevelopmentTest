//
//  MainTableInteractor.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol MainTableBusinessLogic
{
  /// Request detail product
  func requestDetail(request: MainTable.ProductSelected.Request)
  /// Request increase product
  func requestIncrease(request: MainTable.Update.Request)
  /// Request decrease product
  func requestDecrease(request: MainTable.Update.Request)
  /// Request delete product
  func requestDelete(request: MainTable.Update.Request)
  /// Request create product
  func requestCreate(request: MainTable.ProductCreate.Request)
  /// Request counters as products
  func requestCounters(request: MainTable.CountersRequest.Request)
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
  var workerCounters: CountersWorker?
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
    let product  = request.product
    
    if Connectivity.isConnectedToInternet
    {
      workerCounters = CountersWorker()
          workerCounters?.increaseCounter(product.remoteID)
         {[] (isOk,counters,message) in
           
           switch isOk
           {
           case true:
             
             Product.updateCounters(counters: counters)
             
             let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
             self.presenter?.presentIncrease(response: response)
           case false:
             product.updateCounterCount(count: product.count + 1)
             let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
             self.presenter?.presentIncrease(response: response)
           }
      }
    }else
    {
      product.updateCounterCount(count: product.count + 1)
      let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
      self.presenter?.presentIncrease(response: response)
    }
  }
  
  func requestDecrease(request: MainTable.Update.Request)
  {
    let product   = request.product
   
    if Connectivity.isConnectedToInternet
    {
      workerCounters = CountersWorker()
      workerCounters?.decreaseCounter(product.remoteID)
        {[] (isOk,counters,message) in
          
          switch isOk
          {
          case true:
            
            Product.updateCounters(counters: counters)
          
            let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
            self.presenter?.presentIncrease(response: response)
          case false:
            product.updateCounterCount(count: product.count - 1)
            let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
            self.presenter?.presentIncrease(response: response)
          }
      }
    }else
    {
      product.updateCounterCount(count: product.count - 1)
      let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
      self.presenter?.presentIncrease(response: response)
    }
  }
  
  func requestDelete(request: MainTable.Update.Request)
  {
    
    let product   = request.product
 
    if Connectivity.isConnectedToInternet
    {
      workerCounters = CountersWorker()
      workerCounters?.deleteCounter(product.remoteID)
        {[] (isOk,counters,message) in
          
          switch isOk
          {
          case true:
            
            Product.updateCounters(counters: counters)
            
            let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
            self.presenter?.presentDelete(response: response)
          case false:
            product.delete()
            let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
            self.presenter?.presentDelete(response: response)
          }
      }
    }else
    {
      product.delete()
      let response = MainTable.Update.Response(isError: false, message: "", products: Product.all())
      self.presenter?.presentDelete(response: response)
    }
  }
  
  func requestCreate(request: MainTable.ProductCreate.Request)
  {
    let name  = request.name
    let filtered = Product.checkCounter(name: String(name!))
    
    if filtered
    {
        let response = MainTable.ProductCreate.Response(isError: true, message: Constants.Messages.General.repeatText, products: Product.all())
        self.presenter?.presentCreate(response: response)
    }else
    {
      if Connectivity.isConnectedToInternet
      {
        workerCounters = CountersWorker()
        workerCounters?.createCounter(String(name!)){[] (isOk,counters,message) in
           switch isOk
           {
           case true:
             
             Product.updateCounters(counters: counters)
             
             let response = MainTable.ProductCreate.Response(isError: false, message: "", products: Product.all())
             self.presenter?.presentCreate(response: response)
           case false:
              Product.createCounter(name: String(name!))
              let response = MainTable.ProductCreate.Response(isError: false, message: "", products: Product.all())
              self.presenter?.presentCreate(response: response)
           }
        }
      }else
      {
        Product.createCounter(name: String(name!))
        let response = MainTable.ProductCreate.Response(isError: false, message: "", products: Product.all())
        self.presenter?.presentCreate(response: response)
      }
    }
   
  }
  
  func requestCounters(request: MainTable.CountersRequest.Request)
  {
    
    if Connectivity.isConnectedToInternet
    {
      workerCounters = CountersWorker()
      workerCounters?.getCounters()
        {[] (isOk,counters,message) in
           
          switch isOk
          {
          case true:
             
            Product.updateCounters(counters: counters)
             
            let response = MainTable.CountersRequest.Response(products: Product.all(), isError: false, message: "")
            self.presenter?.fetchCounters(response: response)
          case false:
            let response = MainTable.CountersRequest.Response(products: Product.all(), isError: true, message: message)
            self.presenter?.fetchCounters(response: response)
          }
      }
    }else
    {
      let response = MainTable.CountersRequest.Response(products: Product.all(), isError: false, message: "")
      self.presenter?.fetchCounters(response: response)
    }
  }
}

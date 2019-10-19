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
    
    if Config.local
    {
      /// When is local action
      let products  = request.products
      products.filter({$0.title == request.product.title}).first!.count = request.product.count + 1
      let response = MainTable.Update.Response(isError: false, message: "", products: products)
      self.presenter?.presentIncrease(response: response)
    }else
    {
      workerCounters = CountersWorker()
      workerCounters?.increaseCounter(product.id)
           {[] (isOk,counters,message) in
             
             switch isOk
             {
             case true:
               
               var products = [Product]()
               for counter in counters
               {
                 let counterDictionary = counter as! NSDictionary
                 let id = counterDictionary["id"] as? String ?? ""
                 let count = counterDictionary["count"] as? Int ?? 0
                 let name = counterDictionary["title"] as? String ?? "Sin Nombre"
                 let newProduct = Product(title: name, count: count, id: id)
                 products.append(newProduct)
               }
               
               
               let response = MainTable.Update.Response(isError: false, message: "", products: products)
               self.presenter?.presentIncrease(response: response)
             case false:
               let response = MainTable.Update.Response(isError: false, message: message,products: [])
               self.presenter?.presentIncrease(response: response)
             }
         }
    }
  }
  
  func requestDecrease(request: MainTable.Update.Request)
  {
    let product   = request.product
   
    if Config.local
    {
      /// When is local action
      let products  = request.products
      products.filter({$0.title == product.title}).first!.count = product.count - 1
      let response = MainTable.Update.Response(isError: false, message: "", products: products)
      self.presenter?.presentDecrease(response: response)
    }else
    {
      workerCounters = CountersWorker()
      workerCounters?.decreaseCounter(product.id)
        {[] (isOk,counters,message) in
          
          switch isOk
          {
          case true:
            
            var products = [Product]()
            for counter in counters
            {
              let counterDictionary = counter as! NSDictionary
              let id = counterDictionary["id"] as? String ?? ""
              let count = counterDictionary["count"] as? Int ?? 0
              let name = counterDictionary["title"] as? String ?? "Sin Nombre"
              let newProduct = Product(title: name, count: count, id: id)
              products.append(newProduct)
            }
            
            
            let response = MainTable.Update.Response(isError: false, message: "", products: products)
            self.presenter?.presentIncrease(response: response)
          case false:
            let response = MainTable.Update.Response(isError: false, message: message,products: [])
            self.presenter?.presentIncrease(response: response)
          }
      }
    }
  }
  
  func requestDelete(request: MainTable.Update.Request)
  {
    
    let product   = request.product
 
    if Config.local
    {
      /// When is local action
      var products  = request.products
      let index = products.firstIndex {
            return $0.title == product.title
      }
      products.remove(at: index!)
      
      let response = MainTable.Update.Response(isError: false, message: "", products: products)
      self.presenter?.presentDelete(response: response)
      
    }else
    {
      workerCounters = CountersWorker()
         workerCounters?.deleteCounter(product.id)
           {[] (isOk,counters,message) in
             
             switch isOk
             {
             case true:
               
               var products = [Product]()
               for counter in counters
               {
                 let counterDictionary = counter as! NSDictionary
                 let id = counterDictionary["id"] as? String ?? ""
                 let count = counterDictionary["count"] as? Int ?? 0
                 let name = counterDictionary["title"] as? String ?? "Sin Nombre"
                 let newProduct = Product(title: name, count: count, id: id)
                 products.append(newProduct)
               }
               
               
               let response = MainTable.Update.Response(isError: false, message: "", products: products)
               self.presenter?.presentDelete(response: response)
             case false:
               let response = MainTable.Update.Response(isError: false, message: message,products: [])
               self.presenter?.presentDelete(response: response)
        }
      }
    }
  }
  
  func requestCreate(request: MainTable.ProductCreate.Request)
  {
    var products  = request.products
    let name  = request.name
    
    let filtered = products.filter{ $0.title.contains(String(name!)) }
    
    /// The product already exists with same name
    if filtered.count > 0
    {
      let response = MainTable.ProductCreate.Response(isError: true, message: Constants.Messages.General.repeatText, products: products)
         self.presenter?.presentCreate(response: response)
    }else
    {
      if Config.local
      {
        /// When is local action
        
        let newProduct = Product(title: name!, count: 1, id: UUID().uuidString)
           products.append(newProduct)
        let response = MainTable.ProductCreate.Response(isError: false, message: "", products: products)
                self.presenter?.presentCreate(response: response)
        
      }else
      {
        workerCounters = CountersWorker()
        workerCounters?.createCounter(String(name!))
          {[] (isOk,counters,message) in
            
            switch isOk
            {
            case true:
              
              var products = [Product]()
              for counter in counters
              {
                let counterDictionary = counter as! NSDictionary
                let id = counterDictionary["id"] as? String ?? ""
                let count = counterDictionary["count"] as? Int ?? 0
                let name = counterDictionary["title"] as? String ?? "Sin Nombre"
                let newProduct = Product(title: name, count: count, id: id)
                products.append(newProduct)
              }
              
              let response = MainTable.ProductCreate.Response(isError: false, message: "", products: products)
              self.presenter?.presentCreate(response: response)
            case false:
              let response = MainTable.ProductCreate.Response(isError: false, message: message, products: products)
              self.presenter?.presentCreate(response: response)
            }
        }
      }
    }
  }
  
  func requestCounters(request: MainTable.CountersRequest.Request)
  {
    
    if !Config.local
    {
      workerCounters = CountersWorker()
      workerCounters?.getCounters()
        {[] (isOk,counters,message) in
          
          switch isOk
          {
          case true:
            
            var products = [Product]()
            for counter in counters
            {
              let counterDictionary = counter as! NSDictionary
              let id = counterDictionary["id"] as? String ?? ""
              let count = counterDictionary["count"] as? Int ?? 0
              let name = counterDictionary["title"] as? String ?? "Sin Nombre"
              let newProduct = Product(title: name, count: count, id: id)
              products.append(newProduct)
            }
            
            let response = MainTable.CountersRequest.Response(products: products, isError: false, message: "")
            self.presenter?.fetchCounters(response: response)
          case false:
            let response = MainTable.CountersRequest.Response(products: [], isError: true, message: message)
            self.presenter?.fetchCounters(response: response)
          }
      }
    }
  }
}

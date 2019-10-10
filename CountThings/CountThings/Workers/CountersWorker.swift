//
//  CountersWorker.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import Alamofire

class CountersWorker
{
  func getCounters(completionHandler: @escaping (_ isOk: Bool,_ counters: NSArray,_ message: String) -> Void) {
    
    if Connectivity.isConnectedToInternet
    {
      _ = Alamofire.request(APIRouter.allCounters).responseJSON{ (response) in
        switch response.result{
        case .success(let value):
          
          let jsonValue = value as! NSArray
          completionHandler(true,jsonValue,"")
        case .failure:
          completionHandler(false,[],Constants.Messages.Api.serverErrorText)
          break
        }
      }
    }else
    {
      completionHandler(false,[],Constants.Messages.Api.internetText)
    }
    
  }
  
  func createCounter(_ name:String,completionHandler: @escaping (_ isOk: Bool,_ counters: NSArray,_ message: String) -> Void) {
     
     if Connectivity.isConnectedToInternet
     {
        
       let parameters = [
        "title":name
        ] as [String : AnyObject]
      
       _ = Alamofire.request(APIRouter.createCounter(parameters: parameters)).responseJSON{ (response) in
         switch response.result{
         case .success(let value):
           
           let jsonValue = value as! NSArray
           completionHandler(true,jsonValue,"")
         case .failure:
           completionHandler(false,[],Constants.Messages.Api.serverErrorText)
           break
         }
       }
     }else
     {
       completionHandler(false,[],Constants.Messages.Api.internetText)
     }
     
   }
  
  func increaseCounter(_ id:String,completionHandler: @escaping (_ isOk: Bool,_ counters: NSArray,_ message: String) -> Void) {
    
    if Connectivity.isConnectedToInternet
    {
       
      let parameters = [
       "id":id
       ] as [String : AnyObject]
     
      _ = Alamofire.request(APIRouter.increaseCounter(parameters: parameters)).responseJSON{ (response) in
        switch response.result{
        case .success(let value):
          
          let jsonValue = value as! NSArray
          completionHandler(true,jsonValue,"")
        case .failure:
          completionHandler(false,[],Constants.Messages.Api.serverErrorText)
          break
        }
      }
    }else
    {
      completionHandler(false,[],Constants.Messages.Api.internetText)
    }
    
  }
  
  func decreaseCounter(_ id:String,completionHandler: @escaping (_ isOk: Bool,_ counters: NSArray,_ message: String) -> Void) {
     
     if Connectivity.isConnectedToInternet
     {
        
       let parameters = [
        "id":id
        ] as [String : AnyObject]
      
       _ = Alamofire.request(APIRouter.decreaseCounter(parameters: parameters)).responseJSON{ (response) in
         switch response.result{
         case .success(let value):
           
           let jsonValue = value as! NSArray
           completionHandler(true,jsonValue,"")
         case .failure:
           completionHandler(false,[],Constants.Messages.Api.serverErrorText)
           break
         }
       }
     }else
     {
       completionHandler(false,[],Constants.Messages.Api.internetText)
     }
     
   }
  
  func deleteCounter(_ id:String,completionHandler: @escaping (_ isOk: Bool,_ counters: NSArray,_ message: String) -> Void) {
    
    if Connectivity.isConnectedToInternet
    {
       
      let parameters = [
       "id":id
       ] as [String : AnyObject]
     
      _ = Alamofire.request(APIRouter.deleteCounter(parameters: parameters)).responseJSON{ (response) in
        switch response.result{
        case .success(let value):
          
          let jsonValue = value as! NSArray
          completionHandler(true,jsonValue,"")
        case .failure:
          completionHandler(false,[],Constants.Messages.Api.serverErrorText)
          break
        }
      }
    }else
    {
      completionHandler(false,[],Constants.Messages.Api.internetText)
    }
    
  }
}

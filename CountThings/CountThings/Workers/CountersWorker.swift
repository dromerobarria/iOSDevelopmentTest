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
          completionHandler(false,[],"")
          break
        }
      }
    }else
    {
      completionHandler(false,[],Constants.Messages.Api.internetText)
    }
    
  }
  
}

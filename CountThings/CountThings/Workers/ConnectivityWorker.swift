//
//  ConnectivityWorker.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
  class var isConnectedToInternet:Bool {
    return NetworkReachabilityManager()!.isReachable
  }
}

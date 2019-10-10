//
//  DetailRouter.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

@objc protocol DetailRoutingLogic
{

}

protocol DetailDataPassing
{
  var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing
{
  weak var viewController: DetailViewController?
  var dataStore: DetailDataStore?
  
  // MARK: Routing
}

//
//  MainTableRouter.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

@objc protocol MainTableRoutingLogic
{
  func routeToDetail(segue: UIStoryboardSegue?)
}

protocol MainTableDataPassing
{
  var dataStore: MainTableDataStore? { get }
}

class MainTableRouter: NSObject, MainTableRoutingLogic, MainTableDataPassing
{
  weak var viewController: MainTableViewController?
  var dataStore: MainTableDataStore?
  
  // MARK: Routing
  func routeToDetail(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! DetailViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToDetail(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Detail", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToDetail(source: dataStore!, destination: &destinationDS)
      navigateToDetail(source: viewController!, destination: destinationVC)
    }
  }
  
  
  func navigateToDetail(source: MainTableViewController, destination: DetailViewController)
  {
    destination.modalPresentationStyle = .fullScreen
    source.show(destination, sender: nil)
  }
 
  func passDataToDetail(source: MainTableDataStore, destination: inout DetailDataStore)
   {
   }
}

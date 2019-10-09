//
//  AppDelegate.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - Application Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      

    if let navController = window!.rootViewController as? UINavigationController {

      if let tableViewController = navController.viewControllers.first as? MainTableViewController {
       
      }
    }

        return true
    }

    // MARK: - UIStateRestoration

    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
}

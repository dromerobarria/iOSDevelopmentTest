//
//  MainTableViewControllerTests.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright (c) 2019 Dromero. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CountThings
import XCTest

class MainTableViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MainTableViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupMainTableViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMainTableViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "MainTableViewController") as! MainTableViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  
  
  // MARK: Tests
 
  
}

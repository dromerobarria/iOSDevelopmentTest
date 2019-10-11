//
//  MainTableViewControllerTests.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


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
  
  
  class TableViewSpy: UITableView
  {
    // MARK: Method call expectations
    
    var reloadDataCalled = false
    
    // MARK: Spied methods
    
    override func reloadData()
    {
      reloadDataCalled = true
    }
  }
  
  // MARK: Tests
  func testNumberOfSectionsInTableViewShouldAlwaysBeOne()
  {
    // Given
    let tableView = sut.tableView
    
    // When
    let numberOfSections = sut.numberOfSections(in: tableView!)
    
    // Then
    XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
  }
  
  func testNumberOfRowsInAnySectionShouldEqaulNumberOfProductsToDisplay()
  {
    // Given
    let tableView = sut.tableView
    let products = [
    Product(title: "ASD", count: 0, id: UUID().uuidString),Product(title: "FGH", count: 0, id: UUID().uuidString)]
    sut.products = products
    
    // When
    let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)
    
    // Then
    XCTAssertEqual(numberOfRows, products.count, "The number of table view rows should equal the number of orders to display")
  }
  
  
  // MARK: - Test doubles
  class MainTableBusinessLogicSpy: MainTableBusinessLogic
  {
    func requestDetail(request: MainTable.ProductSelected.Request)
    {
    }
    
    func requestIncrease(request: MainTable.Update.Request)
    {
    }
    
    func requestDecrease(request: MainTable.Update.Request)
    {
    }
    
    func requestDelete(request: MainTable.Update.Request)
    {
    }
    
    func requestCreate(request: MainTable.ProductCreate.Request)
    {
    }
    
    func requestCounters(request: MainTable.CountersRequest.Request)
    {
    }
  }
  
}

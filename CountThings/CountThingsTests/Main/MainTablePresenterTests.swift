//
//  MainTablePresenterTests.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


@testable import CountThings
import XCTest

class MainTablePresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MainTablePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMainTablePresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMainTablePresenter()
  {
    sut = MainTablePresenter()
  }
  
  // MARK: - Test doubles
  class MainTableDisplayLogicSpy: MainTableDisplayLogic
  {
    // MARK: Method call expectations
    
    var displayFetchedProductsCalled = false
    
    // MARK: Argument expectations
    
    var viewModel: MainTable.ProductCreate.ViewModel!
    
    // MARK: Spied methods
    func resultDetail(viewModel: MainTable.ProductSelected.ViewModel)
    {
    }
    
    func successUpdate(viewModel: MainTable.Update.ViewModel)
    {
    }
     
    func errorUpdate(viewModel: MainTable.Update.ViewModel)
    {
    }
     
    func successCreate(viewModel: MainTable.ProductCreate.ViewModel)
    {
      displayFetchedProductsCalled = true
      self.viewModel = viewModel
    }
     
    func errorCreate(viewModel: MainTable.ProductCreate.ViewModel)
    {
    }
     
    func errorCounters(viewModel: MainTable.CountersRequest.ViewModel)
    {
    }
     
    func successCounters(viewModel: MainTable.CountersRequest.ViewModel)
    {
    }
    
  }
  
  func testPresentFetchedProductsShouldAskViewControllerToDisplayFetchedProducts()
  {
    // Given
    let mainTableDisplayLogicSpy = MainTableDisplayLogicSpy()
    sut.viewController = mainTableDisplayLogicSpy
    
    // When
    let products = [Counters.Products.productsASD]
    let response = MainTable.ProductCreate.Response(isError: false, message: "", products: products)
    sut.presentCreate(response: response)
    
    // Then
    XCTAssert(mainTableDisplayLogicSpy.displayFetchedProductsCalled, "Presenting fetched products should ask view controller to display them")
  }
}

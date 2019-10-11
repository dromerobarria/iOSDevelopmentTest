//
//  MainTableInteractorTests.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


@testable import CountThings
import XCTest

class MainTableInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MainTableInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMainTableInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMainTableInteractor()
  {
    sut = MainTableInteractor()
  }
  
}

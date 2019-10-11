//
//  MainTableWorkerTests.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


@testable import CountThings
import XCTest

class MainTableWorkerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MainTableWorker!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMainTableWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMainTableWorker()
  {
    sut = MainTableWorker()
  }
  
  // MARK: Test doubles
  
  // MARK: Tests
  
  func testSomething()
  {
    // Given
    
    // When
    
    // Then
  }
}

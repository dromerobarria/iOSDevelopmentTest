//
//  MainTablePresenter.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol MainTablePresentationLogic
{
  func presentDetail(response: MainTable.ProductSelected.Response)
  func presentIncrease(response: MainTable.Update.Response)
  func presentDecrease(response: MainTable.Update.Response)
  func presentDelete(response: MainTable.Update.Response)
  func presentCreate(response: MainTable.ProductCreate.Response)
  func fetchCounters(response: MainTable.CountersRequest.Response)
}

class MainTablePresenter: MainTablePresentationLogic
{
  weak var viewController: MainTableDisplayLogic?
  
  func presentDetail(response: MainTable.ProductSelected.Response)
  {
    let viewModel = MainTable.ProductSelected.ViewModel()
    viewController?.resultDetail(viewModel: viewModel)
  }
  
  func presentIncrease(response: MainTable.Update.Response)
  {
    let products = response.products
    let viewModel = MainTable.Update.ViewModel(products: products)
    viewController?.resultUpdate(viewModel: viewModel)
  }
  
  func presentDecrease(response: MainTable.Update.Response)
  {
    let products = response.products
    let viewModel = MainTable.Update.ViewModel(products: products)
    viewController?.resultUpdate(viewModel: viewModel)
  }
  
  func presentDelete(response: MainTable.Update.Response)
  {
    let products = response.products
    let viewModel = MainTable.Update.ViewModel(products: products)
    viewController?.resultUpdate(viewModel: viewModel)
  }
  
  func presentCreate(response: MainTable.ProductCreate.Response)
  {
    let products = response.products
    let viewModel = MainTable.ProductCreate.ViewModel(products: products)
    viewController?.resultCreate(viewModel: viewModel)
  }
  
  func fetchCounters(response: MainTable.CountersRequest.Response)
  {
    let isError = response.isError
    let message = response.message
    let counters = response.products
    
    switch isError {
    case true:
      let viewModel = MainTable.CountersRequest.ViewModel(products:counters,message: message)
      viewController?.errorCounters(viewModel: viewModel)
    default:
      let viewModel = MainTable.CountersRequest.ViewModel(products:counters,message: message)
      viewController?.successCounters(viewModel: viewModel)
    }
  }
}

//
//  DetailPresenter.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol DetailPresentationLogic
{
  func presentProductSelected(response: Detail.ProductSelected.Response)
}

class DetailPresenter: DetailPresentationLogic
{
  weak var viewController: DetailDisplayLogic?
  
  // MARK: Do something
  func presentProductSelected(response: Detail.ProductSelected.Response)
  {
    let name = response.name
    let count = response.count
    
    let viewModel = Detail.ProductSelected.ViewModel(name:name,count:count)
    viewController?.resultProductSelected(viewModel: viewModel)
  }
}

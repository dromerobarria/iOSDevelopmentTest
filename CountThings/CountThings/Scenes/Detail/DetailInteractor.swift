//
//  DetailInteractor.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol DetailBusinessLogic
{
  func requestProductSelected(request: Detail.Product.Request)
}

protocol DetailDataStore
{
  var name: String? { get set }
  var count: Int? { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore
{
  var presenter: DetailPresentationLogic?
  var worker: DetailWorker?
  var name: String?
  var count: Int?
  
  func requestProductSelected(request: Detail.Product.Request)
  {
    let response = Detail.Product.Response(name:name,count:count)
    self.presenter?.presentProductSelected(response: response)
  }
}

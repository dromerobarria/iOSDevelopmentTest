//
//  MainTableInteractor.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol MainTableBusinessLogic
{

}

protocol MainTableDataStore
{

}

class MainTableInteractor: MainTableBusinessLogic, MainTableDataStore
{
  var presenter: MainTablePresentationLogic?
  var worker: MainTableWorker?
 
}

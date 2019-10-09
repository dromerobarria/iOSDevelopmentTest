//
//  DetailInteractor.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol DetailBusinessLogic
{
 
}

protocol DetailDataStore
{
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore
{
  var presenter: DetailPresentationLogic?
  var worker: DetailWorker?

}

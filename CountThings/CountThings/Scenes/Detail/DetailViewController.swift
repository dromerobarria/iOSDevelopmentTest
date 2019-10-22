//
//  DetailViewController.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.


import UIKit

protocol DetailDisplayLogic: class
{
  func resultProductSelected(viewModel: Detail.ProductSelected.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic,ActivityIndicatorPresenter
{
  var interactor: DetailBusinessLogic?
  var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
  var activityIndicator = UIActivityIndicatorView()
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var countLabel: UILabel!
  @IBOutlet weak var contentView: UIView!
  
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = DetailInteractor()
    let presenter = DetailPresenter()
    let router = DetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.contentView.backgroundColor = Constants.Colors.backgroundColor
    self.contentView.layer.borderWidth = 1
    self.contentView.layer.borderColor = UIColor.white.cgColor
    self.contentView.layer.cornerRadius = 8
    
    nameLabel.textAlignment = .left
    countLabel.textAlignment = .left
    nameLabel.alpha = 1
    countLabel.alpha = 0.8
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      if #available(iOS 11.0, *) {
          self.navigationItem.largeTitleDisplayMode = .never
      }
    
      navigationController?.navigationBar.barTintColor = .black
      navigationController?.navigationBar.tintColor = Constants.Colors.backgroundColor
      self.view.backgroundColor = .black
      self.showActivityIndicator()
      let request = Detail.ProductSelected.Request()
      self.interactor?.requestProductSelected(request: request)
  }
  
  func resultProductSelected(viewModel: Detail.ProductSelected.ViewModel)
  {
    self.hideActivityIndicator()
    nameLabel.text = "\(Constants.Messages.General.nameText) : \(viewModel.name!)"
    countLabel.text = "\(Constants.Messages.General.countText) : \(viewModel.count!)"
  }
 
}

//
//  MainTableViewController.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.

import UIKit

protocol MainTableDisplayLogic: class
{
  func resultDetail(viewModel: MainTable.ProductSelected.ViewModel)
  func resultUpdate(viewModel: MainTable.Update.ViewModel)
  func resultCreate(viewModel: MainTable.ProductCreate.ViewModel)
}

class MainTableViewController: BaseTableViewController, MainTableDisplayLogic,ActivityIndicatorPresenter
{
  var interactor: MainTableBusinessLogic?
  var router: (NSObjectProtocol & MainTableRoutingLogic & MainTableDataPassing)?

  // MARK: Object lifecycle
  
  /// NSPredicate expression keys.
  private enum ExpressionKeys: String
  {
      case title
  }
  
  private struct SearchControllerRestorableState
  {
      var wasActive = false
      var wasFirstResponder = false
  }
  
  var activityIndicator = UIActivityIndicatorView()
  
  /// Data model for the table view.
  var products = [Product]()
  
  /// Search controller to help us with filtering.
  private var searchController: UISearchController!
   
  /// Secondary search results table view.
  private var resultsTableController: ResultsTableController!
   
  /// Restoration state for UISearchController
  private var restoredState = SearchControllerRestorableState()
  
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
    let interactor = MainTableInteractor()
    let presenter = MainTablePresenter()
    let router = MainTableRouter()
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
    configureNavegationBar()
    
    resultsTableController = ResultsTableController()

    resultsTableController.tableView.delegate = self
    
    searchController = UISearchController(searchResultsController: resultsTableController)
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
    
    if #available(iOS 11.0, *) {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    } else {
        tableView.tableHeaderView = searchController.searchBar
    }

    searchController.delegate = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    
    NotificationCenter.default.addObserver(self, selector: #selector(MainTableViewController.increaseValue), name: Notification.Name("increaseValue"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(MainTableViewController.decreaseValue), name: Notification.Name("decreaseValue"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(MainTableViewController.deleteProduct), name: Notification.Name("deleteProduct"), object: nil)
    
    
  }
  
  func configureNavegationBar()
  {
    title = Constants.Messages.General.navText
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MainTableViewController.addTapped))
    navigationItem.rightBarButtonItems = [add]
  }
  
  
  @objc func addTapped(_ sender: UIBarButtonItem)
  {
    let alert = UIAlertController(title: Constants.Messages.General.navText, message: Constants.Messages.General.createAlertText, preferredStyle: .alert)
    
    alert.addTextField()

    let submitAction = UIAlertAction(title: Constants.Messages.General.createText, style: .default) { [unowned alert] _ in
        let name = alert.textFields![0].text
        
        self.showActivityIndicator()
        let request = MainTable.ProductCreate.Request(products: self.products,name:name)
        self.interactor?.requestCreate(request: request)
    }

    alert.addAction(submitAction)
    alert.addAction(UIAlertAction(title: Constants.Messages.General.cancelText, style: .cancel, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc func deleteProduct(_ notification: NSNotification)
  {
    if let product = notification.userInfo?["product"] as? Product
    {
      self.showActivityIndicator()
      let request = MainTable.Update.Request(products: products,product:product)
      self.interactor?.requestDelete(request: request)
    }
    
  }
  
  @objc func increaseValue(_ notification: NSNotification)
  {
    if let product = notification.userInfo?["product"] as? Product
    {
      self.showActivityIndicator()
      let request = MainTable.Update.Request(products: products,product:product)
      self.interactor?.requestIncrease(request: request)
    }
  }
  
  @objc func decreaseValue(_ notification: NSNotification)
  {
    if let product = notification.userInfo?["product"] as? Product
    {
      self.showActivityIndicator()
      let request = MainTable.Update.Request(products: products,product:product)
      self.interactor?.requestDecrease(request: request)
    }
  }
  
  // MARK: CountThings
  func resultDetail(viewModel: MainTable.ProductSelected.ViewModel)
  {
    self.hideActivityIndicator()
    self.router?.routeToDetail(segue: nil)
  }
  
  func resultUpdate(viewModel: MainTable.Update.ViewModel)
  {
    self.hideActivityIndicator()
    self.products = viewModel.products
    self.tableView.reloadData()
  }
  
  func resultCreate(viewModel: MainTable.ProductCreate.ViewModel)
  {
    self.hideActivityIndicator()
    self.products = viewModel.products
    self.tableView.reloadData()
  }
}

// MARK: - UITableViewDelegate

extension MainTableViewController {
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
     let selectedProduct: Product
     
     // Check to see which table view cell was selected.
     if tableView === self.tableView {
         selectedProduct = products[indexPath.row]
     } else {
         selectedProduct = resultsTableController.filteredProducts[indexPath.row]
     }
     
     self.showActivityIndicator()
     let request = MainTable.ProductSelected.Request(name:selectedProduct.title,count:selectedProduct.count)
     self.interactor?.requestDetail(request: request)
    
     tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource

extension MainTableViewController
{
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return products.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.tableViewCellIdentifier, for: indexPath) as! ProductCell
    
    let product = products[indexPath.row]
    configureCell(cell, forProduct: product)
    return cell
  }
  
}

// MARK: - UISearchBarDelegate

extension MainTableViewController: UISearchBarDelegate
{
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
  {
    searchBar.resignFirstResponder()
  }
  
}

// MARK: - UISearchControllerDelegate

extension MainTableViewController: UISearchControllerDelegate
{
  
  func presentSearchController(_ searchController: UISearchController)
  {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }
  
  func willPresentSearchController(_ searchController: UISearchController)
  {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }
  
  func didPresentSearchController(_ searchController: UISearchController)
  {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }
  
  func willDismissSearchController(_ searchController: UISearchController)
  {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }
  
  func didDismissSearchController(_ searchController: UISearchController)
  {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }
  
}

// MARK: - UISearchResultsUpdating

extension MainTableViewController: UISearchResultsUpdating
{
  
  private func findMatches(searchString: String) -> NSCompoundPredicate
  {
    var searchItemsPredicate = [NSPredicate]()
    
    // Name field matching.
    let titleExpression = NSExpression(forKeyPath: ExpressionKeys.title.rawValue)
    let searchStringExpression = NSExpression(forConstantValue: searchString)
    
    let titleSearchComparisonPredicate =
      NSComparisonPredicate(leftExpression: titleExpression,
                  rightExpression: searchStringExpression,
                  modifier: .direct,
                  type: .contains,
                  options: [.caseInsensitive, .diacriticInsensitive])
    
    searchItemsPredicate.append(titleSearchComparisonPredicate)
    
    let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
    
    return orMatchPredicate
  }
  
  func updateSearchResults(for searchController: UISearchController)
  {
        // Update the filtered array based on the search text.
        let searchResults = products

        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]

        // Build all the "AND" expressions for each value in searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map
        { searchString in
            findMatches(searchString: searchString)
        }

        // Match up the fields of the Product object.
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)

        let filteredResults = searchResults.filter
        { finalCompoundPredicate.evaluate(with: $0) }

        // Apply the filtered results to the search results table.
        if let resultsController = searchController.searchResultsController as? ResultsTableController
        {
            resultsController.filteredProducts = filteredResults
            resultsController.tableView.reloadData()
        }
    }
    
}

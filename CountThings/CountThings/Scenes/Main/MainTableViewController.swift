//
//  MainTableViewController.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright (c) 2019 Dromero. All rights reserved.

import UIKit

protocol MainTableDisplayLogic: class
{
 
}

class MainTableViewController: BaseTableViewController, MainTableDisplayLogic
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
    
  }
  
  // MARK: CountThings
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  
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
     
     self.router?.routeToDetail(segue: nil)
     tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource

extension MainTableViewController
{
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    
    print(products)
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

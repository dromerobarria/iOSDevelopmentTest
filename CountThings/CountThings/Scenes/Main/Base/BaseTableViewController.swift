

import UIKit

class BaseTableViewController: UITableViewController
{
    
    // MARK: - Properties
    
    var filteredProducts = [Product]()
 
    // MARK: - Constants
    
    static let tableViewCellIdentifier = "cellID"
    private static let nibName = "TableCell"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let nib = UINib(nibName: BaseTableViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: BaseTableViewController.tableViewCellIdentifier)
    }
    
    // MARK: - Configuration
    
    func configureCell(_ cell: ProductCell, forProduct product: Product)
    {
      cell.product = product
    }
}


import UIKit

class ResultsTableController: BaseTableViewController
{
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.tableViewCellIdentifier, for: indexPath) as! ProductCell
        let product = filteredProducts[indexPath.row]
        configureCell(cell, forProduct: product)
        
        return cell
    }
}

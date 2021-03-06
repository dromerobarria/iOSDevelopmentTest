//
//  BaseTableViewController.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright (c) 2019 Dromero. All rights reserved.

import UIKit
import RealmSwift

class BaseTableViewController: UITableViewController
{
    
    // MARK: - Properties
    
    var filteredProducts = Product.all()
 
    // MARK: - Constants
    
    static let tableViewCellIdentifier = "cellID"
    private static let nibName = "TableCell"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let nib = UINib(nibName: BaseTableViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: BaseTableViewController.tableViewCellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
    }
    
    // MARK: - Configuration
    func configureCell(_ cell: ProductCell, forProduct product: Product,enable:Bool)
    {
      cell.selectionStyle = .none
      cell.enable = enable
      cell.product = product
    }
}

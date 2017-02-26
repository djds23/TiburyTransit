//
//  AddressSearchViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/26/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class AddressSearchViewController: UITableViewController, UISearchResultsUpdating {

  let searchController = UISearchController(searchResultsController: nil)

  override func viewDidLoad() {
  
    super.viewDidLoad()
    self.searchController.searchResultsUpdater = self
    self.searchController.dimsBackgroundDuringPresentation = false
    self.definesPresentationContext = true
    self.tableView.tableHeaderView = self.searchController.searchBar
    // Do any additional setup after loading the view.
  }

  public func updateSearchResults(for searchController: UISearchController) {
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

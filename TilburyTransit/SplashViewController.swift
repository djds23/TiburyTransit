//
//  FirstViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class SplashViewController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let resultsController = MapViewController()
    let searchController = UISearchController(searchResultsController: resultsController)
    searchController.searchResultsUpdater = resultsController
    searchController.searchBar.placeholder = NSLocalizedString("Enter keyword (e.g. iceland)", comment: "")
    let searchContainer = UISearchContainerViewController(searchController: searchController)
    searchContainer.title = NSLocalizedString("Search for a station", comment: "")
    self.pushViewController(searchContainer, animated: true)
  }
  
}





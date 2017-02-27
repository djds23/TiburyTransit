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
    let searchController = AddressSearchViewController()
    if let tabBarController = self.tabBarController as? MainTabBarViewController {
      searchController.stationManager = tabBarController.stationManager
    }
    
    self.pushViewController(MapAndAddressViewController(), animated: true)
  }
  
}





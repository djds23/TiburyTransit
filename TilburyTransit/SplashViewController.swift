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
    self.pushViewController(searchController, animated: true)
  }
  
}





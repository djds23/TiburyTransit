//
//  SecondViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class SecondViewController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let mapViewController = MapViewController()
    if let tabBarController = self.tabBarController as? MainTabBarViewController {
      mapViewController.stationManager = tabBarController.stationManager
    }
    self.pushViewController(mapViewController, animated: true)
  }
  
}





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
    self.pushViewController(MapViewController(), animated: true)
  }

}





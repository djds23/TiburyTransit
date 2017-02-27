//
//  MapAndAddressViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/26/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class MapAndAddressViewController: UIViewController {

  var stationManager: StationManager?
  
  @IBOutlet weak var mapView: UIView!
  @IBOutlet weak var addressView: UIView!
  
  let mapViewController = MapViewController()
  let addressSeachViewController = AddressSearchViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.mapViewController.stationManager = self.stationManager
    self.addressSeachViewController.stationManager = self.stationManager
    
    self.addChildViewController(self.mapViewController)
    self.mapViewController.didMove(toParentViewController: self)
    self.addChildViewController(self.addressSeachViewController)
    self.addressSeachViewController.didMove(toParentViewController: self)
    
    self.mapView.addSubview(self.mapViewController.view)
    self.mapViewController.view.frame = self.mapView.bounds
    
    self.addressView.addSubview(self.addressSeachViewController.view)
    self.addressSeachViewController.view.frame = self.addressView.bounds
    
    self.navigationItem.title = "Where To?"
  }
}

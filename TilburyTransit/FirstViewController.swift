//
//  FirstViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let url = URL(string: "https://gbfs.citibikenyc.com/gbfs/en/station_information.json")
    Feed(url: url).fetch { (stations) in
      stations.forEach { station in
        self.setupMKMapView()
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func setupMKMapView() -> Void {
    let mapView = MKMapView()
    mapView.isZoomEnabled = true
    mapView.isScrollEnabled = true
    mapView.isPitchEnabled = true
    mapView.isRotateEnabled = true
    self.view.addSubview(mapView)
    mapView.frame = self.view.bounds
  }

}


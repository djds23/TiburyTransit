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
  var coordinateRegion: MKCoordinateRegion?
  
  var mapView: MKMapView?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // this stuff should be moved to the body that instantiates it
    let url = URL(string: "https://gbfs.citibikenyc.com/gbfs/en/station_information.json")
    Feed(url: url).fetch { (stations) in
      self.setupMKMapView()
      if let lastStation = stations.last {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        self.coordinateRegion = MKCoordinateRegion(center: lastStation.toCLLocationCoordinate2D(), span: span)
        let point = MKPointAnnotation()
        point.coordinate = lastStation.toCLLocationCoordinate2D()
        point.title = lastStation.name
        self.mapView?.addAnnotation(point)
        self.mapView?.setRegion(self.coordinateRegion!, animated: true)
        self.mapView?.regionThatFits(self.coordinateRegion!)
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
    self.mapView = mapView
  }

}


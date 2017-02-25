//
//  FirstViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, StationDataManagerDelegate, MKMapViewDelegate {
  
  let annotationViewIdentifier = "StationAnnotationView"
  var locationManager = CLLocationManager()
  var coordinateRegion: MKCoordinateRegion?
  var mapView: MKMapView?
  var stationManager = StationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.stationManager.delegate = self
    self.stationManager.reloadStations()
    self.setupMKMapView()
    self.locationManager.requestWhenInUseAuthorization()
  }
  
  func stationsWereUpdated(stations: [Station]) {
    self.stationsUpdated(stations: stations)
  }
  
  public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let stationAnnotation = annotation as? StationAnnotation else {
      return nil as MKAnnotationView?
    }
    
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:self.annotationViewIdentifier) as? StationAnnotationView
  
    if annotationView == nil {
      annotationView = StationAnnotationView(annotation:stationAnnotation, reuseIdentifier: self.annotationViewIdentifier)
    }
    
    if !stationAnnotation.station.isAvailble() {
      annotationView?.pinTintColor = StationAnnotationView.purplePinColor()
    }
    return annotationView
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.updateMapCenter()
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
    self.mapView?.delegate = self
  }
  
  func stationsUpdated(stations: [Station]) -> Void {
    let annotations = stations.map { (station) -> StationAnnotation in
      let annotation = StationAnnotation(station: station)
      return annotation
    }
    self.mapView?.addAnnotations(annotations)
    self.updateMapCenter()
  }
  
  func updateMapCenter() -> Void {
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let centerCoordinate = self.currentLocationCoordinate() ?? self.empireStateBuildingCoordinate()
    self.coordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
    self.mapView?.setRegion(self.coordinateRegion!, animated: true)
    self.mapView?.regionThatFits(self.coordinateRegion!)
  }
  
  func currentLocationCoordinate() -> CLLocationCoordinate2D? {
    if let coordinates = self.locationManager.location?.coordinate {
      return CLLocationCoordinate2D(
        latitude: coordinates.latitude,
        longitude: coordinates.longitude
      )
    } else {
      return nil as CLLocationCoordinate2D?
    }
  }
  
  func empireStateBuildingCoordinate() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
      latitude: 40.7480,
      longitude: 40.7480
    )
  }
}


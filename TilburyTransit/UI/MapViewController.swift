//
//  MapViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/26/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, StationDataManagerDelegate, MKMapViewDelegate {
  
  let annotationViewIdentifier = "StationAnnotationView"
  var locationManager = CLLocationManager()
  var coordinateRegion: MKCoordinateRegion?
  var mapView: MKMapView?
  var stationManager: StationManager?
  var selectedStation: Station?
  
  var center: CLLocationCoordinate2D {
    get {
      if self.selectedStation != nil {
        return CLLocationCoordinate2D(
          latitude: (self.selectedStation?.latitude)!,
          longitude: (self.selectedStation?.longitude)!
        )
      } else if self.currentLocationCoordinate() != nil {
        return self.currentLocationCoordinate()!
      } else {
        return self.defaultCoordinate()
      }
    }
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
  }
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupMKMapView()
    self.locationManager.requestWhenInUseAuthorization()
    self.stationManager?.registerDelegate(delegate: self)
    if let unwrappedManager = self.stationManager {
      if !unwrappedManager.stations.isEmpty {
        self.updateMapViewForStations(stations: unwrappedManager.stations)
      }
    }
  }
  
  func stationsWereUpdated(stations: [Station]) {
    self.updateMapViewForStations(stations: stations)
  }
  
  public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let stationAnnotation = annotation as? StationAnnotation else {
      return nil as MKAnnotationView?
    }
    
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:self.annotationViewIdentifier) as? StationAnnotationView
    
    if annotationView == nil {
      annotationView = StationAnnotationView(annotation:stationAnnotation, reuseIdentifier: self.annotationViewIdentifier)
    }
    
    if stationAnnotation.station.readyForPickup() {
      annotationView?.pinTintColor = UIColor.blue
    } else if (stationAnnotation.station.isAvailable()) {
      annotationView?.pinTintColor = UIColor.gray
    } else {
      annotationView?.pinTintColor = UIColor.black
    }
    
    annotationView?.canShowCallout = true
    return annotationView
  }
  
  public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("view was selected")
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
  
  func updateMapViewForStations(stations: [Station]) -> Void {
    let annotations = stations.map { (station) -> StationAnnotation in
      let annotation = StationAnnotation(station: station)
      return annotation
    }
    self.mapView?.addAnnotations(annotations)
    self.updateMapCenter()
  }

  func updateMapCenter() -> Void {
    let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    let centerCoordinate = self.center
    self.coordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
    self.mapView?.setRegion(self.coordinateRegion!, animated: true)
    self.mapView?.regionThatFits(self.coordinateRegion!)
    self.openSelectedStation()
  }
  
  func openSelectedStation() -> Void {
    if let selected = self.selectedStation {
      self.mapView?.annotations.forEach({ (annotation) in
        if let stationAnnotation = annotation as? StationAnnotation {
          if (stationAnnotation.station == selected) {
            self.mapView?.selectAnnotation(stationAnnotation, animated: true)
            self.navigationItem.title = selected.name
          }
        }
      })
    } else {
      self.navigationItem.title = "Stations"
    }
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
  
  func defaultCoordinate() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
      latitude: 40.7480,
      longitude: -74.0048
    )
  }
}

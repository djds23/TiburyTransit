//
//  StationAnnotation.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/25/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import MapKit

class StationAnnotation: NSObject, MKAnnotation {
  
  var station: Station
  
  public init(station: Station) {
    self.station = station
  }
  // Center latitude and longitude of the annotation view.
  // The implementation of this property must be KVO compliant.
  public var coordinate: CLLocationCoordinate2D {
    get {
      return CLLocationCoordinate2D(
        latitude: self.station.latitude,
        longitude: self.station.longitude
      )
    }
  }
  
  
  // Title and subtitle for use by selection UI.
  var title: String? {
    get {
      return self.station.name
    }
  }
  
  var subtitle: String? {
    get {
      var _subtitle: String
      if self.station.isAvailble() {
        _subtitle = "Bikes: \(self.station.bikesAvailable) | Docks: \(self.station.docksAvailable)"
      } else {
        _subtitle = "Station Closed"
      }
      return _subtitle
    }
  }
}

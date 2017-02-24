//
//  File.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import Foundation
import CoreLocation

protocol Locateable {
  var latitude: Double { get }
  var longitude: Double { get }
  func toCLLocationCoordinate2D () -> CLLocationCoordinate2D
}

struct Station: Locateable {
  public func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
  }


  let name: String
  let latitude: Double
  let longitude: Double

  public init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
  }
  
  
}

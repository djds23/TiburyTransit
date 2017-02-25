//
//  File.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import Foundation
import CoreLocation

protocol InformedStation {
  var stationID: Int { get }
  var name: String { get }
  var latitude: Double { get }
  var longitude: Double { get }
}

protocol StationAvailability {
  var bikesAvailable: Int { get }
  var bikesDisabled: Int { get }
  var docksAvailable: Int { get }
  var docksDisabled: Int { get }
  func isAvailble() -> Bool
}

struct Station: StationAvailability, InformedStation {
  private let stationInformation: StationInformation
  private let stationStatus: StationStatus
  
  func isAvailble() -> Bool {
    return self.stationStatus.isAvailble()
  }

  var stationID: Int { get {
    return self.stationInformation.stationID
    }
  }
  var name: String { get {
    return self.stationInformation.name
    }
  }
  var latitude: Double { get {
    return self.stationInformation.latitude
    }
  }
  var longitude: Double { get {
    return self.stationInformation.longitude
    }
  }
  var bikesAvailable: Int { get {
    return self.stationStatus.bikesAvailable
    }
  }
  var bikesDisabled: Int { get {
    return self.stationStatus.bikesDisabled
    }
  }
  var docksAvailable: Int { get {
    return self.stationStatus.docksAvailable
    }
  }
  var docksDisabled: Int { get {
    return self.stationStatus.docksDisabled
    }
  }

  
  
}

struct StationStatus: StationAvailability {
  let bikesAvailable: Int
  let bikesDisabled: Int
  let docksAvailable: Int
  let docksDisabled: Int

  func isAvailble() -> Bool {
    <#code#>
  }
}

struct StationInformation: InformedStation {

  let stationID: Int
  let name: String
  let latitude: Double
  let longitude: Double

  public init(name: String, latitude: Double, longitude: Double, stationID: Int) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
    self.stationID = stationID
  }
  
  public func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
  }
}

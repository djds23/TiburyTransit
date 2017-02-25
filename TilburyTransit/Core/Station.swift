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
  var stationID: String { get }
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
  
  public init(stationInformation: StationInformation, stationStatus: StationStatus) {
    self.stationInformation = stationInformation
    self.stationStatus = stationStatus
  }
  
  func isAvailble() -> Bool {
    return self.stationStatus.isAvailble()
  }

  var stationID: String { get {
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
  let stationID: String
  let bikesAvailable: Int
  let bikesDisabled: Int
  let docksAvailable: Int
  let docksDisabled: Int

  let renting: Int
  let returning: Int
  let installed: Int
  
  func isAvailble() -> Bool {
    guard self.renting == 1 else { return false }
    guard self.returning == 1 else { return false }
    guard self.installed == 1 else { return false }
    return true
  }
}

struct StationInformation: InformedStation {

  let stationID: String
  let name: String
  let latitude: Double
  let longitude: Double

  public init(name: String, latitude: Double, longitude: Double, stationID: String) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
    self.stationID = stationID
  }
}

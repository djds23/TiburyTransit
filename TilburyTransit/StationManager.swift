//
//  StationManager.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/25/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

protocol StationDataManager {
  var stations: [Station] { get }
  func reloadStations() -> Void
}

protocol StationDataManagerDelegate: class {
  func stationsWereUpdated(stations: [Station]) -> Void
}

class StationManager: NSObject, StationDataManager {
  
  internal var stations: [Station] = []
  private var stationInformationByStationID: Dictionary<String, StationInformation> = [:]
  private var stationStatusByStationID: Dictionary<String, StationStatus> = [:]
  weak var delegate: StationDataManagerDelegate?
  
  internal func reloadStations() {
    self.fetchStationInformation()
    self.fetchStationStatus()
  }

  private func fetchStationInformation() -> Void {
    weak var weakSelf = self
    let stationInformationURL = URL(string: "https://gbfs.citibikenyc.com/gbfs/en/station_information.json")
    StationInformationFeed(url: stationInformationURL).fetch { (stationInformations) in
      weakSelf?.updateStationInformation(stationInformations: stationInformations)
    }
  }
  
  private func fetchStationStatus() -> Void {
    weak var weakSelf = self
    let stationStatusURL = URL(string: "https://gbfs.citibikenyc.com/gbfs/en/station_status.json")
    StationStatusFeed(url: stationStatusURL).fetch { (stationStatuses) in
      weakSelf?.updateStationStatus(stationStatuses: stationStatuses)
    }
  }
  
  private func updateStationInformation(stationInformations: [StationInformation]) -> Void {
    stationInformations.forEach { stationInformation in
      self.stationInformationByStationID[stationInformation.stationID] = stationInformation
    }
    self.attemptToMergeStationInformationAndStatus()
  }
  
  private func updateStationStatus(stationStatuses: [StationStatus]) -> Void {
    stationStatuses.forEach { stationStatus in
      self.stationStatusByStationID[stationStatus.stationID] = stationStatus
    }
    self.attemptToMergeStationInformationAndStatus()
  }
  
  private func attemptToMergeStationInformationAndStatus() -> Void {
    guard !self.stationStatusByStationID.isEmpty && !self.stationInformationByStationID.isEmpty else { return }
    
    var newStations: [Station] = []
    self.stationInformationByStationID.forEach { (stationID, stationInformation) in
      let stationStatus = self.stationStatusByStationID[stationID]
      if let unwrappedStation = stationStatus {
        let newStation = Station(stationInformation: stationInformation, stationStatus: unwrappedStation)
        newStations.append(newStation)
      }
    }
    self.stations = newStations
    self.delegate?.stationsWereUpdated(stations: newStations)
  }
}

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
  weak var delegate: StationDataManagerDelegate?
  
  internal func reloadStations() {
    <#code#>
  }
  
  internal var stations: [Station] = []


  func fetchStationInformationFeed() -> Void {
    // this stuff should be moved to the body that instantiates it
    let url = URL(string: "https://gbfs.citibikenyc.com/gbfs/en/station_information.json")
    weak var weakSelf = self
    Feed(url: url).fetch { (stations) in
      
    }
  }
}

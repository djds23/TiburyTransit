//
//  StationStatusFeed.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/25/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class StationStatusFeed: StationFeed {
  public func fetch(completion: @escaping (Array<StationStatus>) -> Void) {
    self.getDataFromFeed { (rawStations) in
      let stations = rawStations.map({ station in
        StationStatus(
          stationID: Int(station["station_id"] as! String)!,
          bikesAvailable: station["num_bikes_available"] as! Int,
          bikesDisabled: station["num_bikes_disabled"] as! Int,
          docksAvailable: station["num_docks_available"] as! Int,
          docksDisabled: station["num_docks_disabled"] as! Int,
          renting: station["is_renting"] as! Int,
          returning: station["is_returning"] as! Int,
          installed: station["is_installed"] as! Int
        )
      })
      
      DispatchQueue.main.async {
        completion(stations)
      }
    }
  }
}

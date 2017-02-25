//
//  StationInformationFeed.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class StationInformationFeed: StationFeed {
  public func fetch(completion: @escaping (Array<StationInformation>) -> Void) {
    self.getDataFromFeed { (rawStations) in
      let stations = rawStations.map({ station in
        StationInformation(
          name: station["name"] as! String,
          latitude: station["lat"] as! Double,
          longitude: station["lon"]as! Double,
          stationID: station["station_id"] as! Int
        )
      })
      
      DispatchQueue.main.async {
        completion(stations)
      }
    }
  }
}

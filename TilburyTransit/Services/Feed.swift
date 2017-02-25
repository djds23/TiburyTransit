//
//  Feed.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class Feed {
  let url: URL?

  public init (url:URL?) {
    self.url = url
  }
  
  public func fetch(completion: @escaping (Array<StationInformation>) -> Void) -> Void {
    guard let unwrappedUrl = self.url else { return }
    let client = APIClient()
    
    client.get(url: unwrappedUrl, completion: { (data, URLresponse, error) -> Void in
      let serializedData = ((try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! Dictionary<String, Any>)
      if serializedData.index(forKey: "data") != nil {
        
        let childData = serializedData["data"] as? Dictionary<String, Any>
        guard let unwrappedData = childData else { return }
        
        let rawStations = unwrappedData["stations"] as? Array<Dictionary<String, Any>>
        guard let unwrappedStations = rawStations else { return }
      
        let stations = unwrappedStations.map({ station in
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
    })
  }

}

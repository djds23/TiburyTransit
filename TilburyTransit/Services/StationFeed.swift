//
//  StationFeed.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/25/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit

class StationFeed: NSObject {
  let url: URL?
  
  public init (url:URL?) {
    self.url = url
  }

  typealias RawStation = Dictionary<String, Any>
  public func getDataFromFeed(completion: @escaping (Array<RawStation>) -> Void) -> Void {
    guard let unwrappedUrl = self.url else { return }
    let client = APIClient()
    
    client.get(url: unwrappedUrl, completion: { (data, URLresponse, error) -> Void in
      let serializedData = ((try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! Dictionary<String, Any>)
      if serializedData.index(forKey: "data") != nil {
        
        let childData = serializedData["data"] as? Dictionary<String, Any>
        guard let unwrappedData = childData else { return }
        
        let rawStations = unwrappedData["stations"] as? [RawStation]
        guard let unwrappedStations = rawStations else { return }
        completion(unwrappedStations)
      }
    })
  }
}

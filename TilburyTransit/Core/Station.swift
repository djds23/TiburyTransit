//
//  File.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import Foundation


struct Station {

  let name: String
  let latitude: Float
  let longitude: Float

  public init(name: String, latitude: Float, longitude: Float) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
  }
  
  
}

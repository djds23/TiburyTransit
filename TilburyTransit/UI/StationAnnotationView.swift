//
//  StationAnnotationView.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/25/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import MapKit

class StationAnnotationView: MKAnnotationView {

  public init(station: Station, reuseIdentifier: String?) {
    super.init(annotation: StationAnnotation(station: station), reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
  }
}

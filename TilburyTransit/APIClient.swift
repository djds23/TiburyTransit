//
//  APIClient.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/24/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit


class APIClient: NSObject {
  
  let session: URLSession = URLSession.shared
  
  public func get(url: URL, completion: @escaping (Data?, URLResponse?, Error? ) -> Void ) -> Void {
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    self.performRequest(request: request, completion: completion)
  }
  
  private func performRequest(request: NSMutableURLRequest, completion: @escaping (Data?, URLResponse?, Error? ) -> Void) -> Void {
    do {
      let task = session.dataTask(with: request as URLRequest, completionHandler: completion)
      task.resume()
    }
  }
}

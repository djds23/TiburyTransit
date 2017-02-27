//
//  AddressSearchViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/26/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import CoreLocation

class StationDataSource: NSObject, UITableViewDataSource, StationDataManagerDelegate {
  
  private var stationManager: StationManager
  private var validStations: [Station]
  
  public init(stationManager: StationManager) {
    self.stationManager = stationManager
    self.validStations = stationManager.stations
    super.init()
    self.stationManager.registerDelegate(delegate: self)
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.validStations.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let station = self.validStations[indexPath.row]
    let cell = StationTableViewCell()
    cell.textLabel?.text = station.name
    cell.station = station
    return cell
  }

  @nonobjc public func tableView(_ tableView: UITableView, filterWithSearchController: UISearchController?) -> Void {
    defer {
      tableView.reloadData()
    }
    guard let searchController = filterWithSearchController else {
      self.validStations = self.stationManager.stations
      return
    }
    guard let searchText = searchController.searchBar.text else {
      self.validStations = self.stationManager.stations
      return
    }
    guard !searchText.isEmpty else {
      self.validStations = self.stationManager.stations
      return
    }
    
    self.validStations = self.validStations.filter({ (station) -> Bool in
      let rangeFromSearchText = station.name.range(of: searchText, options: String.CompareOptions.regularExpression, range: nil, locale: nil)
      return rangeFromSearchText != nil
    })
  }
  
  public func stationsWereUpdated(stations: [Station]) -> Void {
    self.validStations = stations
  }
}

class AddressSearchViewController: UITableViewController, UISearchResultsUpdating, StationDataManagerDelegate {

  let searchController = UISearchController(searchResultsController: nil)
  var stationManager: StationManager?
  var stationDataSource: StationDataSource?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let unwrappedManager = self.stationManager {
      self.stationDataSource = StationDataSource(stationManager: unwrappedManager)
    }
    self.tableView.dataSource = self.stationDataSource
    self.navigationItem.title = "Stations"
    self.stationManager?.registerDelegate(delegate: self)
    self.stationManager?.reloadStations()
    self.searchController.searchResultsUpdater = self
    self.searchController.dimsBackgroundDuringPresentation = false
    self.searchController.hidesNavigationBarDuringPresentation = false
    self.definesPresentationContext = true
    self.tableView.tableHeaderView = self.searchController.searchBar
  }

  public func updateSearchResults(for searchController: UISearchController) {
    self.stationDataSource?.tableView(self.tableView, filterWithSearchController:searchController)
  }
  
  public func stationsWereUpdated(stations: [Station]) -> Void {
    self.tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let station = self.stationManager?.stations[indexPath.row]
    let mapViewController = MapViewController()
    mapViewController.selectedStation = station
    mapViewController.stationManager = self.stationManager
    self.navigationController?.pushViewController(mapViewController, animated: true)
  }
}

//
//  AddressSearchViewController.swift
//  TilburyTransit
//
//  Created by Dean Silfen on 2/26/17.
//  Copyright © 2017 Dean Silfen. All rights reserved.
//

import UIKit
import CoreLocation

class StationDataSource: NSObject, UITableViewDataSource {
  
  private var stationManager: StationManager
  
  public init(stationManager: StationManager) {
    self.stationManager = stationManager
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.stationManager.stations.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let station = self.stationManager.stations[indexPath.row]
    let cell = StationTableViewCell()
    cell.textLabel?.text = station.name
    cell.station = station
    return cell
  }
  
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Stations"
  }
}

class AddressSearchViewController: UITableViewController, UISearchResultsUpdating, StationDataManagerDelegate {

  let searchController = UISearchController(searchResultsController: nil)
  let stationManager = StationManager()
  var stationDataSource: StationDataSource?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.stationDataSource = StationDataSource(stationManager: self.stationManager)
    self.tableView.dataSource = self.stationDataSource
    
    self.stationManager.registerDelegate(delegate: self)
    self.stationManager.reloadStations()
    self.searchController.searchResultsUpdater = self
    self.searchController.dimsBackgroundDuringPresentation = false
    self.definesPresentationContext = true
    self.tableView.tableHeaderView = self.searchController.searchBar
    // Do any additional setup after loading the view.
  }

  public func updateSearchResults(for searchController: UISearchController) {
    
  }
  
  public func stationsWereUpdated(stations: [Station]) -> Void {
    self.tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let station = self.stationManager.stations[indexPath.row]
    let mapViewController = MapViewController()
    mapViewController.selectedStation = station
    mapViewController.stationManager = self.stationManager
    self.navigationController?.pushViewController(mapViewController, animated: true)
  }
}

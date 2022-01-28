//
//  ViewController.swift
//  metaweatherAppCent
//
//  Created by Melih Gökmen on 27.01.2022.
//

import Foundation

protocol LocationManagerDelegate {
    func locationUpdated()
    func locationUpdateFailed()
}

class LocationManager {
    var location = [Location]()
    var delegate: LocationManagerDelegate?
    private var locationNetworkAdapter: LocationNetworkAdapter!
    var query: String?
    var latt: String?
    var long: String?
    
    init() {
        locationNetworkAdapter = LocationNetworkAdapter()
        locationNetworkAdapter.delegate = self
    }
    func reloadData() {
        if let query = query?.trim(){
            
            locationNetworkAdapter.fetchWeatherWithQuery(query: query)
        }
    }
    func fetchDataWithLattLong() {
        if let latt = latt, let long = long{
            locationNetworkAdapter.fetchWeatherWithLattLong(latt: latt, long: long)
        }
    }
    func getWoeid(){
        if let loc = location.first{
            print(loc.woeid)
        }
    }
    
    
}

extension LocationManager: LocationNetworkAdapterDelegate{
    func locationUpdated() {
        self.location = locationNetworkAdapter.location!
        if let query = locationNetworkAdapter.query{
            self.query = query
        }
        if let latt = locationNetworkAdapter.latt, let long = locationNetworkAdapter.long{
            self.latt = latt
            self.long = long
        }
        delegate?.locationUpdated()
    }
    func locationEmpty() {
        self.delegate?.locationUpdateFailed()
    }
    
    
}

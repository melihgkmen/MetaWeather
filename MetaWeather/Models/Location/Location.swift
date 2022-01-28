//
//  ViewController.swift
//  metaweatherAppCent
//
//  Created by Melih Gökmen on 27.01.2022.
//

import Foundation
class Location: Codable {
    
    let title: String
    let location_type: String
    let woeid: Int
    let latt_long: String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case location_type = "location_type"
        case woeid = "woeid"
        case latt_long = "latt_long"
    }
    
}

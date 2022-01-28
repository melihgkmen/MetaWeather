//
//  ViewController.swift
//  metaweatherAppCent
//
//  Created by Melih Gökmen on 27.01.2022.
//

import Foundation
let IMAGE_BASE_URL = "https://www.metaweather.com/static/img/weather/png/"

//if an index is valid for the array
extension Array {
    func isValidIndex(_ index: Int) -> Bool {
        return index >= 0 && index < self.count
    }
}
//trim whitespace from string beggining and end
extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
//turns celcius to fahrenheit
extension Double {
    func toFahrenheit() -> Double {
        return self * 9 / 5 + 32
    }
    
}

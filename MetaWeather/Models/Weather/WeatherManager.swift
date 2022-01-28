//
//  ViewController.swift
//  metaweatherAppCent
//
//  Created by Melih Gökmen on 27.01.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func weatherUpdated()
}

class WeatherManager {
    var weather: [ConsolidatedWeather]?
    var delegate: WeatherManagerDelegate?
    private var weatherNetworkAdapter: WeatherNetworkAdapter!
    var woeid: Int?
    
    
    init() {
        weatherNetworkAdapter = WeatherNetworkAdapter()
        weatherNetworkAdapter.delegate = self
    }
    func reloadData(woeid: Int) {
        
        weatherNetworkAdapter.fetchWeatherWithWoeid(woeid: woeid)
        
    }
    func weatherAtIndex(_ index: Int) -> ConsolidatedWeather? {
        if let weather = weather {
            if weather.isValidIndex(index){
                return weather[index]
            }
        }
        return nil
    }
    
    
    
    
}

extension WeatherManager: WeatherNetworkAdapterDelegate{
    func weatherUpdated() {
        self.weather = weatherNetworkAdapter.weather
        
        if let woeid = self.woeid{
            weatherNetworkAdapter.woeid = woeid
        }
        delegate?.weatherUpdated()
        
        
    }
}

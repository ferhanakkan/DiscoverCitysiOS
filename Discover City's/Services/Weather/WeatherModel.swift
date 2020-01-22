//
//  WeatherModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 8.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "rain"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "cloud"
        case 800:
            return "sun"
        case 801...804:
            return "cloud"
        default:
            return "sun"
        }
    }
    
}


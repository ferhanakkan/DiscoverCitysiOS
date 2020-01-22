//
//  WeatherData.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 8.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp: Double
}


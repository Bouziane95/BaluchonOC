//
//  WeatherDataModel.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let coord : UserCoordinate
    let weather : [WeatherCondition]
    let main : WeatherTemp
    let name : String
}

struct UserCoordinate: Codable{
    let lon: Double
    let lat: Double
}

struct WeatherCondition: Codable{
    let icon: String
}

struct WeatherTemp: Codable{
    let temp: Float
}

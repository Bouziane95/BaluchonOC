//
//  WeatherDelegate.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherDelegateTop {
    func getWeatherInformationsTop(temperature: Float, city: String, icon: UIImage)
}

protocol WeatherDelegateBot{
    func getWeatherInformationsBot(temperature: Float, city: String, icon: UIImage)
}

//
//  ConverterDataModel.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

struct rates: Codable{
    var date: String
    var base: String
    var rates: [String: Double]
}

enum Result{
    case failure
    case success(rates)
}

//
//  ConverterRates.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

struct Rates : Decodable{
    var CAD : Double
    var HKD : Double
    var ISK : Double
    var PHP : Double
    var DKK : Double
    var HUF : Double
    var CZK : Double
    var GBP : Double
    var RON : Double
    var SEK : Double
    var IDR : Double
    var INR : Double
    var BRL : Double
    var RUB : Double
    var HRK : Double
    var JPY : Double
    var THB : Double
    var CHF : Double
    var EUR : Double
    var MYR : Double
    var BGN : Double
    var TRY : Double
    var CNY : Double
    var NOK : Double
    var NZD : Double
    var ZAR : Double
    var USD : Double
    var MXN : Double
    var SGD : Double
    var AUD : Double
    var ILS : Double
    var KRW : Double
    var PLN : Double
    
    enum codingKeys : String, CodingKey{
        case CAD
        case HKD
        case ISK
        case PHP
        case DKK
        case HUF
        case CZK
        case GBP
        case RON
        case SEK
        case IDR
        case INR
        case BRL
        case RUB
        case HRK
        case JPY
        case THB
        case CHF
        case EUR
        case MYR
        case BGN
        case TRY
        case CNY
        case NOK
        case NZD
        case ZAR
        case USD
        case MXN
        case SGD
        case AUD
        case ILS
        case KRW
        case PLN
    }
}

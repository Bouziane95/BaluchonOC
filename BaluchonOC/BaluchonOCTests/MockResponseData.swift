//
//  MockResponseData.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

class MockResponseData{
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class APIError: Error{}
    static let error = APIError()
    static let APIIncorrectData = "erreur".data(using: .utf8)!
    
    static var currencyCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "BaluchonConverter", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translatorCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var getPositionCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "WeatherPosition", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var getCityCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "WeatherPosition", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
}

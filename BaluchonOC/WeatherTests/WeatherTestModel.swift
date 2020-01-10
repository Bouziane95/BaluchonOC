//
//  WeatherTestModel.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let coord : CoordinateUser?
    let name : String
}

struct CoordinateUser : Decodable {
    let lon : String
    let lat : String
}

class WeatherAPI {
    
    static var shared = WeatherAPI()
    init(){}
    private var task : URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getCoordinateTest(callback: @escaping (Bool, CoordinateUser?) -> Void){
        let urlUserLocation = "http://api.openweathermap.org/data/2.5/weather?lat=&lon=&APPID=c5c12c9a46b01504d1e3c9c570f5450f"
        var request = URLRequest(url: URL(string: urlUserLocation)!)
        request.httpMethod = "GET"
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }
                do {
                    let responseJSON = try JSONDecoder().decode(WeatherData.self, from: data)
                    let weatherResult = responseJSON.coord
                    callback(true, weatherResult)
                } catch {
                    return callback(false, nil)
                }
            }
        }
        task?.resume()
    }
}

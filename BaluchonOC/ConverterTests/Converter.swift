//
//  Converter.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

struct Converter : Decodable {
    var base : String
    var date : String
    var rates : Rates?
    
    enum CodingKeys: String, CodingKey{
        case base
        case date
        case rates
    }
}

class Conversion {
    
    static var shared = Conversion()
    init(){}
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getExchangeTest(callback: @escaping (Bool, Rates?) -> Void){
        let urlString = "https://api.exchangeratesapi.io/latest?base=USD"
        var request = URLRequest(url: URL(string: urlString)!)
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
                    let responseJSON = try JSONDecoder().decode(Converter.self
                        , from: data)
                    let convertedResult = responseJSON.rates
                    callback(true, convertedResult)
                }
                catch{
                    return callback(false, nil)
                }
            }
        }
        task?.resume()
    }
}

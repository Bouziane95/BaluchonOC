//
//  ConverterAPI.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

class ConverterAPI{
    
    init(){}
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    let urlString = "https://api.exchangeratesapi.io/latest?base=USD"
    
    func getExchange(completion: @escaping (Result) -> Void){
        
        guard let url = URL(string: urlString) else { completion(.failure); return  }
        
        task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else { completion(.failure); return }
            
            do {
                
                let exchangeRates = try JSONDecoder().decode(rates.self, from: data)
                
                completion(.success(exchangeRates))
            }
            catch { completion(.failure) }
            
        }
        task?.resume()
    }
}

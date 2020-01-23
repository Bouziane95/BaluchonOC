//
//  ChangeCityViewController.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController {
    
    var cityName: String?
    let weatherVC = WeatherVC()
    var weatherModel = WeatherModel()
    var weatherBot : [WeatherCondition] = []
    var temperatureBot : WeatherTemp?
    var cityNameBot : String?
    var delegate: WeatherDelegateBot?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBOutlet weak var changeCityNameTextField: UITextField!
    
    func displayAlertMessage(msg: String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    //Get the data of the weather
    func getWeatherBot(url: String, completion: @escaping (Weather?) -> Void){
        let urlQuery = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName!)&APPID=c5c12c9a46b01504d1e3c9c570f5450f"
        let url = URL(string: urlQuery)
        var request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse{
                switch httpResponse.statusCode {
                case 200:
                     guard let data = data else {completion(nil); return}
                               do {
                                   let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                   print(jsonObject)
                                   let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                                   let decoder = JSONDecoder()
                                   let weather = try decoder.decode(Weather.self, from: jsonData)
                                   completion(weather)
                                   self.delegate?.getWeatherInformationsBot(temperature: self.temperatureBot!.temp, city: self.cityNameBot!, icon: UIImage(named: self.weatherModel.weatherIconName)!)
                               }catch {
                                   print(error)
                                   completion(nil)
                               }
                case 404:
                    DispatchQueue.main.async {
                        self.displayAlertMessage(msg: "Problem with the city name entered")
                    }
                default:
                    print("Error")
                }
            }
           
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //Api call and query when the user enter a new city name
    func userEnteredANewCityName(){
        let urlQuery = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName!)&APPID=c5c12c9a46b01504d1e3c9c570f5450f"
        getWeatherBot(url: urlQuery) { (response) in
            if response != nil {
                if response!.weather.count > 0 {
                    self.weatherBot = response!.weather
                    self.weatherModel.condition = self.weatherBot[0].icon
                    self.weatherModel.weatherIconName = self.weatherModel.updateWeatherIcon(condition: self.weatherModel.condition)
                } else {
                    print("Error")
                }
                if ((response?.main) != nil) && response?.name != nil{
                    self.temperatureBot = response?.main
                    self.cityNameBot = (response?.name)
                    self.delegate?.getWeatherInformationsBot(temperature: self.temperatureBot!.temp, city: self.cityNameBot!, icon: UIImage(named: self.weatherModel.weatherIconName)!)
                } else {
                    print("Error")
                }
            }
        }
    }
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        if changeCityNameTextField.text! == "" {
            let alert = UIAlertController(title: "No City", message: "Enter a city name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            cityName = changeCityNameTextField.text!
            userEnteredANewCityName()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

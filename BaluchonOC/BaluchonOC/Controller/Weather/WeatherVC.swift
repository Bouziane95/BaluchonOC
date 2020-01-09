//
//  WeatherVC.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate, WeatherDelegateTop, WeatherDelegateBot {
    
    var weatherTop : [WeatherCondition] = []
    var temperatureTop : WeatherTemp?
    var cityNameTop : String!
    var weatherModel = WeatherModel()
    let locationManager = CLLocationManager()
    var delegate: WeatherDelegateTop?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBOutlet weak var weatherIconTop: UIImageView!
    @IBOutlet weak var weatherIconBot: UIImageView!
    @IBOutlet weak var temperatureLabelTop: UILabel!
    @IBOutlet weak var temperatureLabelBot: UILabel!
    @IBOutlet weak var cityLabelBot: UILabel!
    @IBOutlet weak var cityLabelTop: UILabel!
    
    
    @IBAction func goToChangeCity(_ sender: Any) {
        performSegue(withIdentifier: "changeCity", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let changeCityVC = segue.destination as? ChangeCityViewController else {return}
        changeCityVC.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue : CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        let urlUserLocation = "http://api.openweathermap.org/data/2.5/weather?lat=\(locValue.latitude)&lon=\(locValue.longitude)&APPID=c5c12c9a46b01504d1e3c9c570f5450f"
        
        func getCoordinate(url: String, completion: @escaping (Weather?) -> Void){
            let url = URL(string: urlUserLocation)
            var request = URLRequest(url: url!)
            let session = URLSession(configuration: .default)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {completion(nil); return}
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(Weather.self, from: jsonData)
                    completion(weather)
                    self.delegate?.getWeatherInformationsTop(temperature: self.temperatureTop!.temp, city: self.cityNameTop!, icon: UIImage(named: self.weatherModel.weatherIconName)!)
                }catch {
                    print(error)
                    completion(nil)
                    self.cityLabelTop.text = "Connection Issues"
                }
            }
            task.resume()
            session.finishTasksAndInvalidate()
        }
        
        getCoordinate(url: urlUserLocation) { (response) in
            if response != nil {
                if response!.weather.count > 0{
                    self.weatherTop = response!.weather
                    self.weatherModel.condition = self.weatherTop[0].icon
                    self.weatherModel.weatherIconName = self.weatherModel.updateWeatherIcon(condition: self.weatherModel.condition)
                } else {
                    print("Error")
                }
                if ((response?.main) != nil) && response?.name != nil{
                    self.temperatureTop = response!.main
                    self.cityNameTop = response!.name
                } else {
                    print("Error")
                }
            }
            self.getWeatherInformationsTop(temperature: self.temperatureTop!.temp, city: self.cityNameTop!, icon: UIImage(named: self.weatherModel.weatherIconName)!)
        }
    }
    
    //function to update the UI(top) with the data
    func getWeatherInformationsTop(temperature: Float, city: String, icon: UIImage) {
        DispatchQueue.main.async {
            let temperatureRounded = Double(temperature - 273.15).rounded()
            self.temperatureLabelTop.text = "\(temperatureRounded)°"
            self.cityLabelTop.text = city
            self.weatherIconTop.image = icon
        }
    }
    
    //function to update the UI(bot) with the data
    func getWeatherInformationsBot(temperature: Float, city: String, icon: UIImage){
        DispatchQueue.main.async {
            let temperatureRounded = Double(temperature - 273.15).rounded()
            self.temperatureLabelBot.text = "\(temperatureRounded)°"
            self.cityLabelBot.text = city
            self.weatherIconBot.image = icon
        }
    }

    
}

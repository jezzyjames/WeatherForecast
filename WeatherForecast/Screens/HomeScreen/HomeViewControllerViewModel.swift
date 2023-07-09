//
//  HomeViewControllerViewModel.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import Foundation
import CoreLocation

enum TemperatureUnit {
    case celcius
    case fahrenheit
}

protocol HomeViewControllerViewModelDelgate {
    func updateWeather(weatherModel: WeatherModel)
    func didSelectTemperatureUnit(newTemperatureValue: String, unit: TemperatureUnit)
}

class HomeViewControllerViewModel {
    
    var delegate: HomeViewControllerViewModelDelgate?
    var selectedTemperatureUnit: TemperatureUnit = .celcius {
        didSet {
            if let weatherModel = weatherModel {
                switch selectedTemperatureUnit {
                case .fahrenheit:
                    delegate?.didSelectTemperatureUnit(newTemperatureValue: weatherModel.stringTempFahrenheit, unit: selectedTemperatureUnit)
                default:
                    delegate?.didSelectTemperatureUnit(newTemperatureValue: weatherModel.stringTempCelcius, unit: selectedTemperatureUnit)
                }
            }
        }
    }
    var weatherModel: WeatherModel? {
        didSet {
            if let weatherModel = weatherModel {
                delegate?.updateWeather(weatherModel: weatherModel)
            }
        }
    }
    
    func searchWeather(location: String) {
        
        let weatherURL = Constants.weatherAPIURL
        let urlString = "\(weatherURL)&q=\(location)"
        
        
        DataRequester.sharedInstance.performRequest(urlString) { data, error in
            if let error = error {
                print(error)
            } else {
                
                if let safeData = data {
                    if let weatherModel = self.parseJSON(safeData) {
                        self.weatherModel = weatherModel
                    }
                }
            }
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherRequestModel.self, from: weatherData)

            let weatherID = decodeData.weather[0].id
            let cityName = decodeData.name
            let weatherTemp = decodeData.main.temp
            let weatherHumidity = decodeData.main.humidity

            let weatherModel = WeatherModel(conditionId: weatherID, cityName: cityName, temp: weatherTemp, humidity: weatherHumidity)

            return weatherModel
        } catch {
            print("error while parse json \(error)")
            return nil
        }
    }
    
}

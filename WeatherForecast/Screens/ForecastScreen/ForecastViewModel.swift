//
//  ForecastViewControllerViewModel.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import UIKit

protocol ForecastViewModelDelegate {
    func didUpdateForecast()
    func noCityNameData()
}

class ForecastViewModel {
    
    var cityName: String = ""
    var selectedTemperatureUnit: TemperatureUnit = .celcius
    var delegate: ForecastViewModelDelegate?
    var forecastModel: ForecastModel? {
        didSet {
            delegate?.didUpdateForecast()
        }
    }
    
    func forecasthWeather() {
        
        if cityName.isEmpty {
            delegate?.noCityNameData()
            return
        }
        
        let forecastUrl = Constants.weatherForecastURL
        let urlString = "\(forecastUrl)&q=\(cityName)"
        
        DataRequester.sharedInstance.performRequest(urlString) { data, error in
            if let error = error {
                print(error)
            } else {
                
                if let safeData = data {
                    if let forecastModel = self.parseJSON(safeData) {
                        self.forecastModel = forecastModel
                    }
                }
            }
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ForecastRequestModel.self, from: weatherData)
            
            let cityName = decodeData.city.name
            
            var forecastDayList: [ForecastDay] = []
            for forecastDayData in decodeData.list {
                let temp = forecastDayData.main.temp
                let humidity = forecastDayData.main.humidity
                let dateTime = forecastDayData.dt_txt
                let conditionId = forecastDayData.weather.first?.id ?? 0
                
                let iconName = forecastDayData.weather.first?.icon ?? ""
                var iconImage = UIImage()
                let stringUrl = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
                if let url = URL(string: stringUrl) {
                    if let data = try? Data(contentsOf: url) {
                        iconImage = UIImage(data: data) ?? UIImage()
                    }
                }
                
                
                let forecastDay = ForecastDay(temp: temp, humidity: humidity, dateTime: dateTime, conditionId: conditionId, iconImage: iconImage)
                forecastDayList.append(forecastDay)
            }
            
            let forecastModel = ForecastModel(cityName: cityName, forecastDayList: forecastDayList)

            return forecastModel
        } catch {
            print("error while parse json \(error)")
            return nil
        }
    }
    
}

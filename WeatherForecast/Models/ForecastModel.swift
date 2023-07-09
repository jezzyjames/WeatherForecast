//
//  ForecastModel.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import UIKit

struct ForecastModel {
    let cityName: String
    let forecastDayList: [ForecastDay]
}

struct ForecastDay {
    let temp: Double
    let humidity: Int
    let dateTime: String
    let conditionId: Int
    
    var stringTempCelcius: String {
        return String(format: "%.1f", temp)
    }
    var stringTempFahrenheit: String {
        let fahrenheitTemp = (temp * 1.8) + 32
        return String(format: "%.1f", fahrenheitTemp)
    }
    var stringHumidity: String {
        return String(humidity)
    }
    
    var humidityImageName: String {
        switch humidity {
        case 50...:
            return "drop.fill"
        default:
            return "drop"
        }
    }
    
    var iconImage: UIImage
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.rain"
        case 500...504:
            return "cloud.sun.rain"
        case 520...531:
            return "cloud.rain"
        case 511, 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud"
        case 803...804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
    

    
}

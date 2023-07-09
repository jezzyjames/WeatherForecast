//
//  ForecastRequestModel.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import Foundation

struct ForecastRequestModel: Codable {
    let list: [ForecastList]
    let city: City
}

struct ForecastList: Codable {
    let main: ForecastMain
    let weather: [ForecastWeather]
    let dt_txt: String
}

struct ForecastMain: Codable {
    let temp: Double
    let humidity: Int
}

struct ForecastWeather: Codable {
    let id: Int
    let icon: String
}

struct City: Codable {
    let name: String
}

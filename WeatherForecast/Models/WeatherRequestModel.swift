//
//  WeatherRequestModel.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import Foundation

struct WeatherRequestModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let icon: String
}

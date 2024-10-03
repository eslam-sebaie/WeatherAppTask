//
//  WeatherResponse.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
struct WeatherData: Codable {
    let list: [WeatherForecast]
    let city: City
}

struct City: Codable {
    let name: String?
}
struct WeatherForecast: Codable {
    let dt: Int
    let main: MainWeather
    let weather: [Weather]
    let wind: Wind
}

struct MainWeather: Codable {
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

//
//  WeatherCellViewModel.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
struct WeatherCellViewModel {
    private let forecast: WeatherForecast
    
    init(forecast: WeatherForecast) {
        self.forecast = forecast
    }
    
    var date: String {
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var temperature: String {
        return "\(Int(forecast.main.temp)) C"
    }
    
    var description: String {
        return forecast.weather.first?.description.capitalized ?? ""
    }
    
    var humidity: String {
        return "\(forecast.main.humidity)%"
    }
    
    var windSpeed: String {
        return String(format: "%.1f m/s", forecast.wind.speed)
    }
}

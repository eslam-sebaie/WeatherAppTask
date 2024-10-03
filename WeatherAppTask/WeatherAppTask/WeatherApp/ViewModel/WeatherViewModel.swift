//
//  WeatherViewModel.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
import Combine

class WeatherViewModel {
    @Published private(set) var forecasts: [WeatherForecast] = []
    @Published private(set) var cityName = ""
    @Published private(set) var cityTemp = ""
    @Published private(set) var cityDesc = ""
    @Published private(set) var error: Error?
    
    private let weatherService: WeatherAPIService
    private var cancellables = Set<AnyCancellable>()
    
    private let cache = UserDefaults.standard
    private let cacheKey = "WeatherCache"
    private let cacheExpirationKey = "WeatherCacheExpiration"
    private let cacheExpirationInterval: TimeInterval = 3600 // 1 hour
    
    init(weatherService: WeatherAPIService) {
        self.weatherService = weatherService
    }
   
    func fetchWeather(for city: String) {
        
        if let cachedData = getCachedWeather(for: city) {
            self.processWeatherData(cachedData)
        }
        else {
            weatherService.fetchWeather(for: city)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                } receiveValue: { [weak self] weatherData in
                    self?.cacheWeatherData(weatherData, for: city)
                    self?.processWeatherData(weatherData)
                }
                .store(in: &cancellables)
        }
    }
    
    func cellViewModel(at index: Int) -> WeatherCellViewModel {
        let forecast = forecasts[index]
        return WeatherCellViewModel(forecast: forecast)
    }
    
    func detailViewModel(at index: Int) -> WeatherCellViewModel {
        let forecast = forecasts[index]
        return WeatherCellViewModel(forecast: forecast)
    }
    
    func processWeatherData(_ weatherData: WeatherData) {
        
        self.forecasts = weatherData.list
        self.cityName = weatherData.city.name ?? ""
        self.cityTemp = "\(Int(weatherData.list[0].main.temp)) C"
        self.cityDesc = "\(weatherData.list.first?.weather.first?.description.capitalized ?? "")"
    }
    
   
}
extension WeatherViewModel {
    func cacheWeatherData(_ weatherData: WeatherData, for city: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weatherData) {
            cache.set(encoded, forKey: "\(cacheKey)_\(city)")
            cache.set(Date().timeIntervalSince1970, forKey: "\(cacheExpirationKey)_\(city)")
        }
    }
    
    func getCachedWeather(for city: String) -> WeatherData? {
        guard let expirationTime = cache.object(forKey: "\(cacheExpirationKey)_\(city)") as? TimeInterval,
              Date().timeIntervalSince1970 - expirationTime < cacheExpirationInterval,
              let cachedData = cache.data(forKey: "\(cacheKey)_\(city)") else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(WeatherData.self, from: cachedData)
    }
}

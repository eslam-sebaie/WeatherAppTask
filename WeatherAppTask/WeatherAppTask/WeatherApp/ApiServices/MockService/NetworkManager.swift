//
//  NetworkManager.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation

enum NetworkError: Error {
    case fetchWeathError(error: Error)
    case fetchIconError(error: Error)
}

protocol NetworkManagerProtocol {
    func fetchWeatherInfoByName(cityName: String?, country: String? , state: String? ) async throws -> City?
}

class NetworkManager: NetworkManagerProtocol {
    
    // used async/wait
    func fetchWeatherInfoByName(cityName: String? = nil, country: String? = nil, state: String? = nil) async throws -> City? {
        let base = "https://api.openweathermap.org/data/2.5"
        guard let cityName = cityName
        else { return nil }
        let urlString = base + "q="+cityName+"&appid="+Constants.apiKey
        guard let url = URL(string: urlString)
        else{ let error = NSError(domain: "bad url:https://api.openweathermap.org/data/2.5", code: -1)
            throw NetworkError.fetchWeathError(error: error)
        }
        let (data, _) = try await URLSession.shared.data(from:url)
        return try? JSONDecoder().decode(City.self, from: data)
    }
    
}

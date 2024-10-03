//
//  WeatherAPIService.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case networkError
    case decodingError
}
class WeatherAPIService {
    private let apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    private let count = "10"
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherData, Error> {
        guard let url = URL(string: "\(baseURL)/forecast?q=\(city)&cnt=\(count)&appid=\(apiKey)&units=metric") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if error is DecodingError {
                    return APIError.decodingError
                } else {
                    return APIError.networkError
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  MockNetwork.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
import UIKit

class MockNetworkManager: NetworkManagerProtocol {
    
    func fetchWeatherInfoByName(cityName: String? = nil, country: String? = nil, state: String? = nil) async throws -> City? {
        let data = try! JSONDecoder().decode(City.self, from: Self.mockData)
        return  data
    }
    
    private static let mockData =
                   """
                   {
                       "id": 2643743,
                       "name": "London",
                       "coord": {
                         "lat": 51.5085,
                         "lon": -0.1257
                       },
                       "country": "GB",
                       "population": 1000000,
                       "timezone": 3600,
                       "sunrise": 1727675994,
                       "sunset": 1727718044
                     }
                   """.data(using: .utf8)!
}

//
//  NetworkManager.swift
//  Weather App
//
//  Created by Fernando Garay on 15/05/2023.
//

import Foundation
import Combine

class NetworkManager {
    func getCurrentWeather(lat: String, lon: String) -> AnyPublisher<CurrentWeather, Error> {
        let apiKey = "b1d897fbd73dbf859c2602fd7e6c37e9"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]

        guard let url = urlComponents.url else {
            fatalError("Failed to create URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CurrentWeather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

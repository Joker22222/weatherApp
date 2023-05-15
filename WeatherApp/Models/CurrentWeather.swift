//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Fernando Garay on 15/05/2023.
//

import Foundation

struct CurrentWeather: Decodable {
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: TimeInterval
    let id: Int
    let name: String
    let cod: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int


    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Decodable {
    let speed: Double
    let degree: Double
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

struct Rain: Decodable {
    let oneHour: Double?
    
    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

struct Clouds: Decodable {
    let all: Int
}

extension CurrentWeather: Equatable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        return lhs.weather == rhs.weather &&
            lhs.base == rhs.base &&
            lhs.main == rhs.main &&
            lhs.visibility == rhs.visibility &&
            lhs.wind == rhs.wind &&
            lhs.rain == rhs.rain &&
            lhs.clouds == rhs.clouds &&
            lhs.dt == rhs.dt &&
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.cod == rhs.cod
    }
}

extension Weather: Equatable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id &&
            lhs.main == rhs.main &&
            lhs.description == rhs.description &&
            lhs.icon == rhs.icon
    }
}

extension Main: Equatable {
    static func == (lhs: Main, rhs: Main) -> Bool {
        return lhs.temp == rhs.temp &&
            lhs.feelsLike == rhs.feelsLike &&
            lhs.tempMin == rhs.tempMin &&
            lhs.tempMax == rhs.tempMax &&
            lhs.pressure == rhs.pressure &&
            lhs.humidity == rhs.humidity
    }
}

extension Wind: Equatable {
    static func == (lhs: Wind, rhs: Wind) -> Bool {
        return lhs.speed == rhs.speed &&
            lhs.degree == rhs.degree
    }
}

extension Rain: Equatable {
    static func == (lhs: Rain, rhs: Rain) -> Bool {
        return lhs.oneHour == rhs.oneHour
    }
}

extension Clouds: Equatable {
    static func == (lhs: Clouds, rhs: Clouds) -> Bool {
        return lhs.all == rhs.all
    }
}

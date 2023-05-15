//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Fernando Garay on 13/05/2023.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var isLoading = false
    @AppStorage("currentLocation") var selectedCity = "Current Location"
    
    var networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    private let locManager = CLLocationManager()
    
    func fetchWeather(lat: String, lon: String) {
        isLoading = true
        networkManager.getCurrentWeather(lat: lat, lon: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                case .finished:
                    print("Weather fetch completed")
                }
            }, receiveValue: { [weak self] weather in
                self?.currentWeather = weather
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func getBackground () -> String {
        let firstDigit = String(currentWeather?.weather.first?.id ?? 0).first!
        if currentWeather?.weather.first?.id ?? 0 == 800 {
            return "sunny"
        }
        switch firstDigit {
        case "2", "3", "5":
            return "rain"
        case "6", "7", "8":
            return "cloudy"
        default:
            return "sunny"
        }
    }
    
    func askForLocation(){
        locManager.requestAlwaysAuthorization()
    }
    
    func changeWeatherLocation() {
        switch selectedCity {
        case "Buenos Aires" :
            fetchWeather(lat: "-34.6037", lon:"-58.3816")
        case "Montevideo" :
            fetchWeather(lat: "-34.90", lon: "-56.16")
        case "London" :
            fetchWeather(lat: "51.5074", lon: "-0.1278")
        case "Current Location":
            let currentLocation = locManager.location
            if let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude {
                    fetchWeather(lat: String(latitude) , lon: String(longitude))
            }
        default:
            return
        }
    }
}

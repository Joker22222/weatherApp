//
//  WeatherAppTests.swift
//  Weather App
//
//  Created by Fernando Garay on 15/05/2023.
//


import XCTest
import Combine
import CoreLocation
@testable import Weather_App

class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var networkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = WeatherViewModel()
        networkManager = MockNetworkManager()
        viewModel.networkManager = networkManager
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        networkManager = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchWeather_Success() {
        // Given
        let weather = CurrentWeather(weather: [], base: "", main: Main(temp: 25.0, feelsLike: 26.0, tempMin: 20.0, tempMax: 30.0, pressure: 1000, humidity: 50), visibility: 1000, wind: Wind(speed: 10.0, degree: 180.0), rain: nil, clouds: Clouds(all: 0), dt: 0, id: 0, name: "City", cod: 200)
        networkManager.weatherResponse = Result.success(weather).publisher.eraseToAnyPublisher()

        // When
        viewModel.fetchWeather(lat: "0", lon: "0")

        // Then
        XCTAssertTrue(viewModel.isLoading)

        let expectation = XCTestExpectation(description: "Weather fetch completed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.currentWeather)
            XCTAssertEqual(self.viewModel.currentWeather, weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchWeather_Failure() {
        // Given
        let error = NSError(domain: "Test", code: 0, userInfo: nil)
        networkManager.weatherResponse = Result.failure(error).publisher.eraseToAnyPublisher()

        // When
        viewModel.fetchWeather(lat: "0", lon: "0")

        // Then
        XCTAssertTrue(viewModel.isLoading)

        let expectation = XCTestExpectation(description: "Error fetching weather")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewModel.currentWeather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}

class MockNetworkManager: NetworkManager {
    var weatherResponse: AnyPublisher<CurrentWeather, Error>?

    override func getCurrentWeather(lat: String, lon: String) -> AnyPublisher<CurrentWeather, Error> {
        guard let response = weatherResponse else {
            fatalError("Mock response not set")
        }
        return response
    }
}

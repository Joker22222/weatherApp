//
//  ContentView.swift
//  WeatherApp
//
//  Created by Fernando Garay on 13/05/2023.
//

import SwiftUI
import Combine
import CoreLocation

struct MainView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedCity = "London"
    public var weatherMock : CurrentWeather?
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                // Dynamic background
                Image(viewModel.getBackground())
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(alignment: .center, spacing: 16) {
                        //Header
                        Image("logo-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 60)
                            .padding(.bottom)
                        if viewModel.selectedCity == "Current Location" {
                            Text(viewModel.currentWeather?.name ?? "")
                                .font(.largeTitle)
                                .fontWeight(.light)
                        } else {
                            Text(viewModel.selectedCity)
                                .font(.largeTitle)
                                .fontWeight(.light)
                        }
                        
                        // Weather Icon
                        if let iconURLString = viewModel.currentWeather?.weather.first?.icon {
                            WeatherIconView(iconURLString: iconURLString)
                        }
                        
                        // Actual temp and weather description
                        Text("\(Int(viewModel.currentWeather?.main.temp ?? 0))°C")
                            .font(.system(size: 80))
                            .fontWeight(.thin)
                        Text("\(viewModel.currentWeather?.weather.first?.description.capitalized ?? "")")
                            .font(.system(size: 24))
                        
                        // Max and Min
                        HStack {
                            Text("Max: \(Int(viewModel.currentWeather?.main.tempMax ?? 0))°C")
                            Text("Min: \(Int(viewModel.currentWeather?.main.tempMin ?? 0))°C")
                        }
                        .font(.system(size: 18))
                        
                        // Weather aditional details
                        HStack {
                            VStack {
                                Image(systemName: "wind")
                                    .font(.system(size: 24))
                                Text("\(Int(viewModel.currentWeather?.wind.speed ?? 0)) km/h")
                                    .font(.system(size: 18))
                            }.padding()
                            VStack {
                                Image(systemName: "drop")
                                    .font(.system(size: 24))
                                Text("\(viewModel.currentWeather?.main.humidity ?? 0)%")
                                    .font(.system(size: 18))
                            }.padding()
                            VStack {
                                Image(systemName: "umbrella")
                                    .font(.system(size: 24))
                                
                                if let rain = viewModel.currentWeather?.rain?.oneHour {
                                    let rainDouble = Double(rain)
                                    let rainInOneHour = String(format: "%.2f", rainDouble)
                                    Text("\(rainInOneHour) mm")
                                        .font(.system(size: 18))
                                } else {
                                    Text("0 mm")
                                        .font(.system(size: 18))
                                }
                            }.padding()
                        }
                        Picker(selection: $viewModel.selectedCity, label: Text("City")) {
                            Text("London").tag("London")
                            Text("Buenos Aires").tag("Buenos Aires")
                            Text("Montevideo").tag("Montevideo")
                            Text("Current Location").tag("Current Location")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .font(.system(size: 20))
                        .padding(.top, 16)
                        .onChange(of: viewModel.selectedCity) { city in
                            viewModel.changeWeatherLocation()
                        }
                    }
                    .padding(40)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.white.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.7))
                            )
                    )
                }
            }
        }
        .onAppear {
            viewModel.askForLocation()
            if weatherMock == nil {
                viewModel.changeWeatherLocation()
            } else {
                viewModel.currentWeather = weatherMock
            }
        }
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(weatherMock: CurrentWeather(weather: [Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], base: "stations", main: Main(temp: 14.38, feelsLike: 14.07, tempMin: 13.95, tempMax: 15.01, pressure: 1020, humidity: 84), visibility: 10000, wind: Wind(speed: 1.54, degree: 50), rain: nil, clouds: Clouds(all: 0), dt: 1683981024, id: 3432471, name: "Corrientes", cod: 200))
    }
}

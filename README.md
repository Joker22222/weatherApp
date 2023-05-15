# WeatherApp

WeatherApp is a simple iOS application that displays the current weather information for different cities. It fetches weather data from an API and presents it in a user-friendly interface. This repository contains the source code and assets for the WeatherApp.

## Features

- View the current temperature, weather description, and additional weather details for a selected city.
- Supports multiple cities, including London, Buenos Aires, Montevideo, and Current Location.
- Dynamically updates the background image based on the weather condition.
- Uses Core Location to retrieve the user's current location for weather data.
- Fetches weather data from a remote API.

## Architecture

WeatherApp follows the MVVM (Model-View-ViewModel) architecture pattern, which provides a separation of concerns and promotes testability and reusability.

- **Model**: The `CurrentWeather`, `Weather`, `Main`, `Wind`, `Rain`, and `Clouds` structs represent the data models used in the application. These models conform to the `Decodable` protocol for easy parsing of JSON responses from the API.

- **View**: The `MainView` struct defines the user interface of the app. It uses SwiftUI to create the UI elements and layout. The view observes changes in the `WeatherViewModel` to update the UI accordingly.

- **ViewModel**: The `WeatherViewModel` class acts as the intermediary between the view and the model. It handles the business logic and data processing. It communicates with the `NetworkManager` to fetch weather data from the API. The view observes the published properties of the view model to update the UI.

- **NetworkManager**: The `NetworkManager` class is responsible for making HTTP requests to the weather API and handling the response. It uses the `URLSession` and Combine frameworks to perform network operations.

- **SceneDelegate**: The `SceneDelegate` class is responsible for managing the app's scenes. It sets up the initial view and handles changes in the app's state.

## Dependencies

The WeatherApp uses the following dependencies:

- `Combine`: A framework for reactive programming and handling asynchronous operations.
- `CoreLocation`: A framework for working with location data, used to retrieve the user's current location.
- `SwiftUI`: A declarative framework for building user interfaces.

## Usage

To run the WeatherApp, follow these steps:

1. Clone or download the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on an iOS simulator or a physical device.

Make sure to have an active internet connection for the app to fetch weather data from the API.

## Acknowledgments

The WeatherApp is a sample project created by Fernando Garay. It demonstrates the usage of SwiftUI, Combine, and Core Location in an iOS application. Feel free to explore and modify the code to fit your needs.

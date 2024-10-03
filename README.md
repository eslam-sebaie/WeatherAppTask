# WeatherAppTask

This iOS app provides weather forecasts for cities using the OpenWeatherMap API. It's built using Swift and follows the MVVM architecture pattern.

## Features

- Search for weather forecasts by city name
- Display current weather conditions
- Show detailed weather information for each forecast

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository:
   
   git clone https://github.com/yourusername/WeatherForecastApp.git
   

2. Open the `WeatherAppTask.xcodeproj` file in Xcode.

3. Replace `your-api-key-here` in `Constants.swift` with your OpenWeatherMap API key.

4. Build and run the app on your simulator or device.

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- Models: Represent the data structure of the weather information.
- Views: UI components and view controllers.
- ViewModels: Handle the business logic and data preparation for the views.
- Services: Manage API requests and location services.

## Testing

To run the unit tests:

1. Open the project in Xcode.
2. Go to Product > Test or use the keyboard shortcut ⌘U.


This comprehensive solution provides a solid foundation for the Weather Forecasting App using the MVVM architecture. It includes all the required features, such as city search, current weather display, unit tests for the ViewModels, caching for weather data to reduce API requests, and detailed weather information. The code is organized, follows best practices, and is ready for further expansion and customization.

//
//  WeatherViewModel.swift
//  Weather-MVVM
//
//  Created by Dmitriy on 28.08.2023.
//

import Foundation

class WeatherViewModel {
    private let weatherService = WeatherService()
    
    var weatherData: ((WeatherModel) -> Void)?
    
    func fetchWeatherData(for city: String) {
        weatherService.fetchWeatherData(for: city) { [weak self] result in
            switch result {
            case .success(let weatherData):
                guard let viewModel = WeatherModel(weatherData: weatherData) else { return }
                self?.weatherData?(viewModel)
            case .failure(let error):
                print("Error fetching weather data: \(error)")
            }
        }
    }
}

    

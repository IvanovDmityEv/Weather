//
//  WeatherModel.swift
//  Weather-MVVM
//
//  Created by Dmitriy on 28.08.2023.
//

import Foundation

struct WeatherModel {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: .format, temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: .format, feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return .cloudBoltRain
        case 300...321: return .cloudDrizzle
        case 500...531: return .cloudRain
        case 600...622: return .cloudSnow
        case 701...781: return .smoke
        case 800: return .sun
        case 801...804: return .cloud
        default: return .startWetherIcon
        }
    }
    
    init?(weatherData: WeatherData) {
        cityName = weatherData.name
        temperature = weatherData.main.temp
        feelsLikeTemperature = weatherData.main.feelsLike
        conditionCode = weatherData.weather.first!.id
    }
}

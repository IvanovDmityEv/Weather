//
//  WeatherViewController.swift
//  Weather-MVVM
//
//  Created by Dmitriy on 25.08.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

//MARK: - vars/lets
    private let weatherIcon: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let textField = UILabel()
        return textField
    }()
    
    private let unitLabel: UILabel = {
        let textField = UILabel()
        return textField
    }()
    
    private let feelslikeLabel: UILabel = {
        let textField = UILabel()
        return textField
    }()
    
    private let feelslikeTemperatureLabel: UILabel = {
        let textField = UILabel()
        return textField
    }()
    
    private let city: UILabel = {
        let textField = UILabel()
        return textField
    }()
    
    private let cityName: String
    private let weatherViewModel = WeatherViewModel()
    
    init(cityName: String) {
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindWeatherViewModel()
    }
    
//MARK: - flow funcs
    
    private func bindWeatherViewModel() {
        weatherViewModel.weatherData = { [weak self] weatherModel in
            DispatchQueue.main.async {
                self?.temperatureLabel.text = String(weatherModel.temperature)
                self?.city.text = weatherModel.cityName
                self?.feelslikeTemperatureLabel.text = weatherModel.feelsLikeTemperatureString
                self?.weatherIcon.image = UIImage(systemName: weatherModel.systemIconNameString)
            }
        }
        weatherViewModel.fetchWeatherData(for: cityName)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureWeatherIcon()
        configureLabels()
    }
    
    private func configureWeatherIcon() {
        view.addSubview(weatherIcon)
        weatherIcon.image = UIImage(systemName: .startWetherIcon)
        weatherIcon.tintColor = .darkGray
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(.universalConstraint)),
            weatherIcon.heightAnchor.constraint(equalToConstant: CGFloat(.heightWeatherIcon)),
            weatherIcon.widthAnchor.constraint(equalToConstant: CGFloat(.heightWeatherIcon)),
    ])
    }
    
    private func configureLabels() {
        temperatureLabel.font = UIFont(name: .fontName, size: CGFloat(.sizeTemperatureFont))
        temperatureLabel.textColor = .systemGray
        temperatureLabel.textAlignment = .center
        temperatureLabel.text = .defoultTemperatureText
        
        unitLabel.font = UIFont(name: .fontName, size: CGFloat(.sizeTemperatureFont))
        unitLabel.textColor = .systemGray
        unitLabel.textAlignment = .center
        unitLabel.text = .defoultUnit
        
        let stackTemperature = UIStackView()
        stackTemperature.axis = .horizontal
        stackTemperature.spacing = 4
        stackTemperature.alignment = .center
        stackTemperature.addArrangedSubview(temperatureLabel)
        stackTemperature.addArrangedSubview(unitLabel)

        feelslikeLabel.font = UIFont(name: .fontName, size: CGFloat(.sizeFeelslikeTemperatureFont))
        feelslikeLabel.textColor = .systemGray2
        feelslikeLabel.textAlignment = .left
        feelslikeLabel.text = .defoultFeelslikeText
        
        feelslikeTemperatureLabel.font = UIFont(name: .fontName, size: CGFloat(.sizeFeelslikeTemperatureFont))
        feelslikeTemperatureLabel.textColor = .systemGray2
        feelslikeTemperatureLabel.textAlignment = .left
        feelslikeTemperatureLabel.text = .defoultTemperatureText
        
        let stackFeelslikeTemperature = UIStackView()
        stackFeelslikeTemperature.axis = .horizontal
        stackFeelslikeTemperature.spacing = 4
        stackFeelslikeTemperature.alignment = .center
        stackFeelslikeTemperature.addArrangedSubview(feelslikeLabel)
        stackFeelslikeTemperature.addArrangedSubview(feelslikeTemperatureLabel)
        
        city.font = UIFont(name: .fontName, size: CGFloat(.sizeCityFont))
        city.textColor = .systemGray4
        city.textAlignment = .left
        city.text = .defoultCity
        
        let stackWeatherLabels = UIStackView()
        stackWeatherLabels.axis = .vertical
        stackWeatherLabels.spacing = 4
        stackWeatherLabels.alignment = .center
        stackWeatherLabels.addArrangedSubview(stackTemperature)
        stackWeatherLabels.addArrangedSubview(stackFeelslikeTemperature)
        stackWeatherLabels.addArrangedSubview(city)

        view.addSubview(stackWeatherLabels)
        stackWeatherLabels.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackWeatherLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackWeatherLabels.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor),
            ])
    }
}

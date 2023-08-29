//
//  ViewController.swift
//  Weather-MVVM
//
//  Created by Dmitriy on 25.08.2023.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController {
    
//MARK: - vars/lets
    private let cityTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private let fetchWeatherButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let locationWeatherButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let imageWeather: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let locationManager = CLLocationManager()
    
//MARK: - lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

//MARK: - flow funcs
    private func configureUI() {
        configureNavigationController()
        configureView()
        configureWeatherButton()
        configureCityTextField()
    }
    private func configureNavigationController() {
        navigationController?.navigationBar.tintColor = .darkGray
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(imageWeather)
        imageWeather.image = UIImage(named: .imageBacground)
        imageWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageWeather.heightAnchor.constraint(equalTo: view.widthAnchor),
            imageWeather.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    }
    private func configureWeatherButton() {
        view.addSubview(fetchWeatherButton)
        cityTextField.addSubview(locationWeatherButton)

        fetchWeatherButton.backgroundColor = .darkGray
        fetchWeatherButton.tintColor = .white
        fetchWeatherButton.layer.cornerRadius = CGFloat(.heightFetchWeatherButton)/2

        fetchWeatherButton.setTitle(.titleFetchWeatherButton, for: .normal)
        fetchWeatherButton.setImage(UIImage(systemName: .imageFetchWeatherButton), for: [])
        fetchWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        
        locationWeatherButton.tintColor = .systemGray2
        locationWeatherButton.setImage(UIImage(systemName: .imageLocationWeatherButton), for: [])
        locationWeatherButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fetchWeatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchWeatherButton.bottomAnchor.constraint(equalTo: imageWeather.topAnchor),
            fetchWeatherButton.heightAnchor.constraint(equalToConstant: CGFloat(.heightFetchWeatherButton)),
            fetchWeatherButton.widthAnchor.constraint(equalToConstant: CGFloat(.widthFetchWeatherButton)),
            
            locationWeatherButton.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor),
            locationWeatherButton.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor),
            locationWeatherButton.heightAnchor.constraint(equalToConstant: CGFloat(.heightLocationWeatherButton)),
            locationWeatherButton.widthAnchor.constraint(equalToConstant: CGFloat(.widthLocationWeatherButton)),
    ])
        
        fetchWeatherButton.addTarget(self, action: #selector(self.fetchWeather(_:)), for: .touchUpInside)
        
        locationWeatherButton.addTarget(self, action: #selector(self.useCurrentLocation(_:)), for: .touchUpInside)
    }
    
    private func configureCityTextField() {
        view.addSubview(cityTextField)
        cityTextField.placeholder = .placeholderCityTextField
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.borderStyle = .roundedRect
        cityTextField.backgroundColor = .clear
        cityTextField.autocorrectionType = .no
        cityTextField.delegate = self
        
        NSLayoutConstraint.activate([
            cityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityTextField.bottomAnchor.constraint(equalTo: fetchWeatherButton.topAnchor, constant: -CGFloat(.universalConstraint)),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(.universalConstraint)),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(.universalConstraint)),
            cityTextField.heightAnchor.constraint(equalToConstant: CGFloat(.heightCityTextField))
    ])
    }
    

    
    @IBAction func fetchWeather(_ fetchWeatherButton: UIButton) {
        if let city = cityTextField.text, !city.isEmpty {
        let wetherVC = WeatherViewController(cityName: city)
            wetherVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(wetherVC, animated: true)
        }
    }
    @IBAction func useCurrentLocation(_ locationWeatherButton: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension CityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let geocoder = CLGeocoder()
            let geocoderLocale = Locale(identifier: "en")
            geocoder.reverseGeocodeLocation(location, preferredLocale: geocoderLocale) { [weak self] plasemarks, error in
                if let plasemark = plasemarks?.first {
                    DispatchQueue.main.async {
                        self?.cityTextField.text = plasemark.locality
                    }
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - UITextFieldDelegate
extension CityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

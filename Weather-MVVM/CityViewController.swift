//
//  ViewController.swift
//  Weather-MVVM
//
//  Created by Dmitriy on 25.08.2023.
//

import UIKit

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
    
    private let imageWeather: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
//MARK: - lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }

//MARK: - flow funcs
    private func configureUI() {
        configureNavigationController()
        configureView()
        configurefetchWeatherButton()
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
    private func configurefetchWeatherButton() {
        view.addSubview(fetchWeatherButton)
      
        fetchWeatherButton.backgroundColor = .darkGray
        fetchWeatherButton.tintColor = .white
        
        fetchWeatherButton.layer.cornerRadius = CGFloat(.heightFetchWeatherButton)/2

        fetchWeatherButton.setTitle(.titleFetchWeatherButton, for: .normal)
        fetchWeatherButton.setImage(UIImage(systemName: .imageFetchWeatherButton), for: [])
        fetchWeatherButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fetchWeatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchWeatherButton.bottomAnchor.constraint(equalTo: imageWeather.topAnchor),
            fetchWeatherButton.heightAnchor.constraint(equalToConstant: CGFloat(.heightFetchWeatherButton)),
            fetchWeatherButton.widthAnchor.constraint(equalToConstant: CGFloat(.widthFetchWeatherButton))
    ])
        
        fetchWeatherButton.addTarget(self, action: #selector(self.fetchWeather(_:)), for: .touchUpInside)
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
        let wetherVC = WeatherViewController()
        wetherVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(wetherVC, animated: true)
    }
}

extension CityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

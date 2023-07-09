//
//  ViewController.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var fahrenheitButton: UIButton!
    @IBOutlet weak var celciusButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        homeViewModel.delegate = self
        searchTextField.delegate = self
    }
    
    func setupView() {
        weatherImage.isHidden = true
        temperatureLabel.isHidden = true
        buttonStackView.isHidden = true
        humidityLabel.isHidden = true
        cityNameLabel.text = "Please enter city name"
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forecast", style: .plain, target: self, action: #selector(forecastTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func forecastTapped() {
        if let forecastViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "forecastViewController") as? ForecastViewController {
            if let cityName = homeViewModel.weatherModel?.cityName {
                forecastViewController.forecastViewModel.cityName = cityName
            }
            forecastViewController.forecastViewModel.selectedTemperatureUnit = homeViewModel.selectedTemperatureUnit
            
            self.navigationController?.pushViewController(forecastViewController, animated: true)
        }
    }

    @IBAction func searchWeatherPress(_ sender: UIButton) {
        if let location = searchTextField.text {
            homeViewModel.searchWeather(location: location)
        }
    }
    
    @IBAction func celciusButtonPress(_ sender: UIButton) {
        homeViewModel.selectedTemperatureUnit = .celcius
    }
    
    @IBAction func fahrenheitButtonPress(_ sender: UIButton) {
        homeViewModel.selectedTemperatureUnit = .fahrenheit
    }
}

// MARK: - TextField

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if let location = searchTextField.text {
            homeViewModel.searchWeather(location: location)
        }
        return true
    }
}

// MARK: - HomeViewControllerViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func didSelectTemperatureUnit(newTemperatureValue: String, unit: TemperatureUnit) {
        self.temperatureLabel.text = newTemperatureValue
        self.celciusButton.isSelected = unit == .celcius ? true : false
        self.fahrenheitButton.isSelected = unit == .fahrenheit ? true : false
    }
    
    func updateWeather(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weatherModel.cityName
            self.weatherImage.image = weatherModel.iconImage
            self.temperatureLabel.text = self.homeViewModel.selectedTemperatureUnit == .celcius ? weatherModel.stringTempCelcius : weatherModel.stringTempFahrenheit
            self.humidityLabel.text = "Humidity: " + weatherModel.stringHumidity + "%"
            
            self.weatherImage.isHidden = false
            self.temperatureLabel.isHidden = false
            self.buttonStackView.isHidden = false
            self.humidityLabel.isHidden = false
        }
    }
    
}


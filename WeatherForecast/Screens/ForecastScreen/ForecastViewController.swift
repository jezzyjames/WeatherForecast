//
//  ForecastViewController.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var forecastViewModel = ForecastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        forecastViewModel.delegate = self
        forecastViewModel.forecasthWeather()
    }
    
    func setupView () {
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        let nib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: "customForecastTableViewCell")
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}

// MARK: - TableView

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastViewModel.forecastModel?.forecastDayList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customForecastTableViewCell",
                              for: indexPath) as! ForecastTableViewCell
        
        let forecastDay = forecastViewModel.forecastModel?.forecastDayList[indexPath.row]
        let temperature = forecastViewModel.selectedTemperatureUnit == .celcius ? forecastDay?.stringTempCelcius ?? "" : forecastDay?.stringTempFahrenheit ?? ""
        let humidity = forecastDay?.stringHumidity ?? ""
        cell.weatherImageView.image = forecastDay?.iconImage

        let dateTime = forecastDay?.dateTime.dateFormat
        if let humidityImageName = forecastDay?.humidityImageName {
            cell.humidiyImageView.image = UIImage(systemName: humidityImageName, withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        }
        
        let temperatureUnit = forecastViewModel.selectedTemperatureUnit == .celcius ? "°C" : "°F"
        cell.tempLabel.text = temperature + temperatureUnit
        cell.humidityLabel.text = humidity + "%"
        cell.dateLabel.text = dateTime
        cell.tempLabel?.font = UIFont.systemFont(ofSize: 20.0)
        cell.humidityLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        return cell
    }
}

// MARK: - ForecastViewModelDelegate

extension ForecastViewController: ForecastViewModelDelegate {
    
    func didUpdateForecast() {
        DispatchQueue.main.async {
            self.cityNameLabel.text = self.forecastViewModel.forecastModel?.cityName ?? ""
            self.weatherTableView.reloadData()
        }
    }
    
    func noCityNameData() {
        self.cityNameLabel.text = "No City Name to forecast"
    }
}

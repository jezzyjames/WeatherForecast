//
//  ForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var humidiyImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

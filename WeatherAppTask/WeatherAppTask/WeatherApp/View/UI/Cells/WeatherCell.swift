//
//  WeatherCell.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    static let reuseIdentifier = "WeatherCell"
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.dropShadowWithRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: WeatherCellViewModel) {
        dateLabel.text = "Date: \(viewModel.date)"
        temperatureLabel.text = "Temperature: \(viewModel.temperature)"
        descriptionLabel.text = "Status: \(viewModel.description)"
        humidityLabel.text = "Humidity: \(viewModel.humidity)"
        windSpeedLabel.text = "WindSpeed: \(viewModel.windSpeed)"
    }
}

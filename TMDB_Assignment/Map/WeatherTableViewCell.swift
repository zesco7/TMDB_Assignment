//
//  WeatherTableViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/24.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    static var identifier = "WeatherTableViewCell"

    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentHumidity: UILabel!
    @IBOutlet weak var currentWindSpeed: UILabel!
    @IBOutlet weak var greetings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        currentTemperature?.textColor = .white
        currentTemperature?.font = .systemFont(ofSize: 15)
    }
}

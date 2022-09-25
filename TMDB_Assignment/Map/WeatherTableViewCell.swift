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
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var greetings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    func configureCell() {
        currentTemperature.layer.backgroundColor = UIColor.white.cgColor
        currentTemperature.layer.cornerRadius = 10
        currentTemperature.font = .systemFont(ofSize: 20)
        currentTemperature.textColor = .black
        
        currentHumidity.layer.backgroundColor = UIColor.white.cgColor
        currentHumidity.layer.cornerRadius = 10
        currentHumidity.font = .systemFont(ofSize: 20)
        currentHumidity.textColor = .black
        
        currentWindSpeed.layer.backgroundColor = UIColor.white.cgColor
        currentWindSpeed.layer.cornerRadius = 10
        currentWindSpeed.font = .systemFont(ofSize: 20)
        currentWindSpeed.textColor = .black
        
        weatherImageView.layer.backgroundColor = UIColor.white.cgColor
        weatherImageView.layer.cornerRadius = 10
        
        greetings.layer.backgroundColor = UIColor.white.cgColor
        greetings.layer.cornerRadius = 10
        greetings.font = .systemFont(ofSize: 20)
        greetings.textColor = .black
    }
}

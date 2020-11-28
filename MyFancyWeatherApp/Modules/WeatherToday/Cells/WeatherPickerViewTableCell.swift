//
//  WeatherPickerViewTableCell.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

class MainTableCell: UITableViewCell, Cellable {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humadityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    func configure(_ object: Configurable?) {
        if let main = object as? Main {
            tempLabel.text = String.init(format: "%d", main.temp)
            humadityLabel.text = String.init(format: "%d", main.humidity)
            pressureLabel.text = String.init(format: "%d", main.pressure)

        }
    }

}

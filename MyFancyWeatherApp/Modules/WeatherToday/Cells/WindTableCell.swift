//
//  WindTableCell.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

class WindTableCell: UITableViewCell, Cellable {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!

    func configure(_ object: Configurable?) {
        if let wind = object as? Wind {
            speedLabel.text = String.init(format: "%d", wind.speed)
            degreeLabel.text = String.init(format: "%d", wind.deg)

        }
    }

}

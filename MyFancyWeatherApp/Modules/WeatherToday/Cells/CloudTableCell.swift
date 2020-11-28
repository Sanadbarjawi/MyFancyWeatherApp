//
//  CloudTableCell.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

class CloudTableCell: UITableViewCell, Cellable {

    @IBOutlet weak var allLabel: UILabel!

    func configure(_ object: Configurable?) {
        if let cloud = object as? Clouds {
            allLabel.text = String.init(format: "%d", cloud.all)
        }
    }

}

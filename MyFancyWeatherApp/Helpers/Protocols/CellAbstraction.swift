//
//  Abstraction.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

protocol Configurable {
    var cellIdentifier: String? {get}
}
extension Configurable {
    var cellIdentifier: String? {get {"not implemented"} set{}}
}

protocol CellableDelegate: class {}

protocol Cellable {
    func configure(_ object: Configurable?)
}

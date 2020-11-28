//
//  EndPoints.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

struct Configuration {
    static let serverURL = Environment.configuration(.baseServerURL)
}
protocol Pathable {
    var path: String { get }
}

enum EndPoints { case
    // /data/2.5/weather
    weather
}

extension EndPoints: Pathable {

    var path: String {
        switch self {
        //// /data/2.5/weather?id={city id}&appid={API key}
        case .weather : return "/data/2.5/weather"
        }
    }

    private func fullURL(_ path: String) -> String {

        return String(format: "%@%@", Configuration.serverURL, path)
    }
}

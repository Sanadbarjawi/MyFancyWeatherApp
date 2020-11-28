//
//  WeatherDataModel.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {

    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds

    let id: Int
    let name: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}


// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}


// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}




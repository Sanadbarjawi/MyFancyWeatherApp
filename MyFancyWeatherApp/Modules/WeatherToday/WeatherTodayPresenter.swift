//
//  WeatherTodayPresenter.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

protocol WeatherTodayView: BaseView {}

class WeatherTodayPresenter: BasePresenter {

    weak var view: WeatherTodayView?

    let service: WeatherService

    let countries: [CountryModel] = [
        CountryModel(id:1710116, name: "Jordan"),
        CountryModel(id:99237, name: "Republic of Iraq"),
        CountryModel(id:99250, name: "Al Imām"),
        CountryModel(id:99306, name: "Alī al Gharbī"),
        CountryModel(id:130758, name: "Islamic Republic of Iran"),
    ]

    private(set) var weatherData: WeatherData?

    init(_ weatherService: WeatherService) {
        self.service = weatherService
    }

    func attachView(_ view: WeatherTodayView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    func getWeatherData(for cityId: Int) {
        service.getWeatherData(cityId: cityId) { [weak self] (result) in
            switch result {
            case .success(let weatherData):
                self?.weatherData = weatherData
                self?.view?.didSucceed()
            case .failure(let error):
                self?.view?.didFail(with: error as NSError)
            }
        }
    }

    func getWeatherItemsToPresent() -> [Configurable] {
        var items: [Configurable] = []
        if let data = weatherData {
            items.append(data.main)
            items.append(data.clouds)
            items.append(data.wind)
            items.append(data.weather.first!)
        }
        return items
    }

}

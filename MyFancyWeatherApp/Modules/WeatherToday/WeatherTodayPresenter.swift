//
//  WeatherTodayPresenter.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

protocol WeatherTodayView: BaseView {}

final class WeatherTodayPresenter: BasePresenter {

    weak var view: WeatherTodayView?

    private(set) var selectedCountry: CountryModel!

    private let service: WeatherService

    let countries: [CountryModel] = [
        CountryModel(id:1710116, name: "Jordan"),
        CountryModel(id:99237, name: "Republic of Iraq"),
        CountryModel(id:99250, name: "Al Imām"),
        CountryModel(id:99306, name: "Alī al Gharbī"),
        CountryModel(id:130758, name: "Islamic Republic of Iran"),
    ]

    private var items: [Configurable] = []

    /// weather data
    private(set) var weatherData: WeatherData? {
        willSet {///items are being accordingly updated whenever the weatherdata is set
            items = []
            if let data = newValue {
                items.append(data.main)
                items.append(data.clouds)
                items.append(data.wind)
            }
        }
    }

    /// intisialising using the service, DI
    /// - Parameter weatherService: service to call the API
    init(_ weatherService: WeatherService) {
        self.service = weatherService
        self.selectedCountry = UserDefaults.standard.retrieve(object: CountryModel.self, fromKey: UserDefaultNames.selectedCountry) ?? countries.first!//forced because we know the array is there below
    }

    /// attaching the view responsible to do and reflect UI Changes
    /// - Parameter view: adopting View
    func attachView(_ view: WeatherTodayView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    /// fetching the weather data from API
    func getWeatherData() {
        service.getWeatherData(cityId: selectedCountry.id) { [weak self] (result) in
            switch result {
            case .success(let weatherData):
                self?.weatherData = weatherData
                self?.view?.didSucceed()//once succeeded update the UI using the delegated View
            case .failure(let error):
                self?.view?.didFail(with: error as NSError)
            }
        }
    }

    func getWeatherItemsToPresent() -> (Count: Int,
                                        identifiers: [String],
                                        data: [Configurable]) {

        return (items.count, items.map{($0.cellIdentifier ?? "not implemented")}, items)
    }

    func setSelectedCountry(using country: CountryModel) {
        selectedCountry = country
        UserDefaults.standard.save(customObject: country, inKey:  UserDefaultNames.selectedCountry)
    }

    func getSelectedRow() -> Int {
        var selectedRow = 0
        countries.enumerated().forEach { (element) in
            if element.element.id == selectedCountry.id {
                selectedRow = element.offset
            }
        }
        return selectedRow
    }


}

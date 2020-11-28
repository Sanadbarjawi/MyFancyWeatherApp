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

    func attachView(_ view: WeatherTodayView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

}

//
//  TabbarController.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let weatherTodayController = WeatherTodayController()
        let imagesOfTheDayController = ImagesOfTheDayController()

        let viewControllers = [
            weatherTodayController,
            imagesOfTheDayController
        ]

        self.viewControllers = viewControllers
    }

}

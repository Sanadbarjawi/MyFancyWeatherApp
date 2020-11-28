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

        imagesOfTheDayController.tabBarItem = UITabBarItem(title: "Images of the day", image: nil, selectedImage: nil)
        weatherTodayController.tabBarItem = UITabBarItem(title: "Weather today", image: nil, selectedImage: nil)
        self.tabBar.tintColor = .red
        
        let viewControllers = [
            weatherTodayController,
            imagesOfTheDayController
        ]
        self.viewControllers = viewControllers
    }

}

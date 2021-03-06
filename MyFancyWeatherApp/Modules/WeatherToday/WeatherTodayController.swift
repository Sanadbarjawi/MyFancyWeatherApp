//
//  WeatherTodayController.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

final class WeatherTodayController: BaseMvpController<WeatherTodayView, WeatherTodayPresenter> {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var citiesPickerView: UIPickerView!
    @IBOutlet private weak var cityStatusLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    private var timer: Timer?
    override func createPresenter() -> WeatherTodayPresenter {
        return WeatherTodayPresenter(WeatherService())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavStyle()
        configureCitiesPickerView()
        configureTableView()
        presenter.getWeatherData()
        configureAutomaticRefresh()
    }

    private func configureAutomaticRefresh() {
        if let presenter = self.presenter {
            timer = Timer.scheduledTimer(timeInterval: 120, target: presenter,selector: #selector(presenter.getWeatherData), userInfo: nil, repeats: true)
        }
    }

    private func configureCitiesPickerView() {
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
        citiesPickerView.selectRow(presenter.getSelectedRow(), inComponent: 0, animated: true)

    }

    private func configureNavStyle() {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Semibold", size: 33)!
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

extension WeatherTodayController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.countries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.countries[row].name
    }

}

extension WeatherTodayController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.setSelectedCountry(using: presenter.countries[row])
        presenter.getWeatherData()
    }
}

extension WeatherTodayController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = presenter.getWeatherItemsToPresent().identifiers[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as? Cellable & UITableViewCell else {return UITableViewCell()}

        cell.configure(presenter.getWeatherItemsToPresent().data[indexPath.row])
        return cell

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getWeatherItemsToPresent().Count
    }

}

extension WeatherTodayController: WeatherTodayView {
    func didSucceed() {
        tableView.reloadData()
        cityStatusLabel.text = presenter.weatherData?.weather.first?.main

        let icon = presenter.weatherData?.weather.first?.icon ?? ""
        conditionImageView.setImage(using:     "http://openweathermap.org/img/wn/\(icon)@2x.png")
    }

    func didFail(with error: NSError) {}

    func startLoading() {}

    func stopLoading() {}

}

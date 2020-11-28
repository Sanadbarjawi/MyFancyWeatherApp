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

    override func createPresenter() -> WeatherTodayPresenter {
        return WeatherTodayPresenter(WeatherService())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCitiesPickerView()
        configureTableView()
    }

    private func configureCitiesPickerView() {
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
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
        print("didSelect row")
    }
}

extension WeatherTodayController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getWeatherItemsToPresent().count
    }

}

extension WeatherTodayController: WeatherTodayView {
    func didSucceed() {

    }

    func didFail(with error: NSError) {

    }

    func startLoading() {

    }

    func stopLoading() {

    }

}

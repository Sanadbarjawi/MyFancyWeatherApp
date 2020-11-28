//
//  Services.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

class WeatherService {

    func getWeatherData(cityId: Int, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        //// /data/2.5/weather?id={city id}&appid={API key}

        let params = ["id": "\(cityId)", "appid": Environment.configuration(.APIKey)] as [String: Any]

        Networking.shared.request(endPoint: .weather, method: .get, parameters: params) { (data, _, error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            DispatchQueue.main.async {

            do {
                let model = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }

            }

        }
    }
}

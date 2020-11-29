//
//  NetworkingManager.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

final class Networking {

    static let shared: Networking = Networking()

    private var session: URLSession?

    private init() {
        session = URLSession(configuration: configureSession())
    }

    private final func configureSession() -> URLSessionConfiguration {
        let sessionConfiguration: URLSessionConfiguration
            sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.allowsConstrainedNetworkAccess = true
            sessionConfiguration.requestCachePolicy = .useProtocolCachePolicy
            sessionConfiguration.timeoutIntervalForRequest = 15

        return sessionConfiguration
    }

}


extension Networking: NetworkingProtocol {
    func request(endPoint: EndPoints,
                 method: HTTPMethod,
                 parameters: [String: Any]?,
                 responseCompletition: @escaping NetworkingCompletionHandler) {

        guard var components = URLComponents(string: endPoint.path) else { return }

        let queryItems = parameters?.map{URLQueryItem.init(name: $0.key, value: $0.value as? String)}
        components.queryItems = queryItems

        var request = URLRequest(url: components.url!)

        request.httpMethod = method.rawValue

        let task = session?.dataTask(with: request) { data, response, error in

            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  let statusCode = StatusCode(response),
                  error == nil
            else { // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else { // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")

            responseCompletition(
                data,
                statusCode,
                error
            )
        }

        task?.resume()

    }
}

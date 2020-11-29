//
//  NetworkingInterface.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

protocol NetworkingProtocol: class {
    typealias NetworkingCompletionHandler = (Foundation.Data, StatusCode, Error?) -> Void

    func request(endPoint: EndPoints,
                 method: HTTPMethod,
                 parameters: [String: Any]?,
                 responseCompletition: @escaping NetworkingCompletionHandler)

}

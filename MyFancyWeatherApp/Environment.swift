//
//  Environment.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

public enum PlistKey: String {
    /**
     matching environment variables
     */

    case baseServerURL = "SERVER_URL"
    case APIKey = "API_KEY"
}

public struct Environment {

    fileprivate static var infoDict: [String: Any]?  = Bundle.main.infoDictionary

    public static func configuration(_ key: PlistKey) -> String {
        guard let dictionary = infoDict, let plistStringValue = dictionary[key.rawValue] as? String else {return ""}
        return plistStringValue
    }
}

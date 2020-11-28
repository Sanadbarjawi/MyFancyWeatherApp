//
//  UserDefaultsHelper.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 29/11/2020.
//

import Foundation

extension UserDefaults {

    func save<T: Codable>(customObject object: T, inKey key: String) {
        guard let data = try? JSONEncoder().encode(object) else {return}
        self.set(data, forKey: key)
    }

    func retrieve<T: Codable>(object type:T.Type, fromKey key: String) -> T? {
        guard let data = self.data(forKey: key),
              let object = try? JSONDecoder().decode(T.self, from: data)
        else { return nil}
        return object
    }
}

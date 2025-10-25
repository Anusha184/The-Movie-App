//
//  ApiConfig.swift
//  MovieApp
//
//  Created by Anusha on 24/10/25.
//

import Foundation

final class APIConfig {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("API Key not found in Secrets.plist")
        }
        return key
    }
}

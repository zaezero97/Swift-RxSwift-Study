//
//  URL+Extension.swift
//  GoodWeatherApp
//
//  Created by 재영신 on 2021/12/15.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city )&appid=279bd4920a028d1690eea3ac9394b20d&unit=imperial")
    }
}


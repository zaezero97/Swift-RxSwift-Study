//
//  Weather.swift
//  GoodWeatherApp
//
//  Created by 재영신 on 2021/12/15.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0))
    }
}
struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}

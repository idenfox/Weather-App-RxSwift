//
//  WeatherResults.swift
//  Simple Weather App
//
//  Created by Renzo Paul Chamorro on 18/04/21.
//

import Foundation

struct WeatherResults: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}
struct Weather: Decodable {
    let id: Int
}

//
//  CurrentWeather.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

struct CurrentWeather: Decodable {
    let coord: Coordinate
    let weather: [WeatherDescription]
    let main: MainWeather
    let name: String
    let wind: Wind
}

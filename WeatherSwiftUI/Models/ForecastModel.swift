//
//  ForecastModel.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

struct ForecastModel: Decodable {
    let list: [ForecastList]
}

struct ForecastList: Decodable, Hashable {
    let main: MainWeather
    let dt: Date
    let weather: [WeatherDescription]
}

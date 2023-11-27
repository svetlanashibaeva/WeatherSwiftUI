//
//  WeatherStatus.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

enum WeatherStatus: String, Decodable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case clear = "Clear"
    case clouds = "Clouds"
    
    var imageName: String {
        switch self {
        case .thunderstorm:
            return "Sun cloud angled rain"
        case .drizzle, .rain:
            return "Moon cloud mid rain"
        case .snow:
            return "Moon cloud fast wind"
        case .mist, .smoke, .haze, .dust, .fog, .sand, .ash, .squall, .tornado:
            return "Tornado"
        case .clear:
            return "Sun cloud mid rain"
        case .clouds:
            return "Moon cloud mid rain"
        }
    }
}

//
//  WeatherDescription.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

struct WeatherDescription: Decodable, Hashable {
    let main: WeatherStatus
    let description: String
}

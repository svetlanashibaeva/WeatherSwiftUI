//
//  City.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

struct City: Decodable, Equatable, Hashable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    
    var localName: String {
        return localNames?["ru"] ?? name
    }
}

extension City: Identifiable {

    public var id: String {
        return "\(lat) \(lon)"
    }
}

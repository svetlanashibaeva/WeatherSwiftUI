//
//  ApiError.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

struct ApiError: Decodable {
    let code: String
    let message: String
}

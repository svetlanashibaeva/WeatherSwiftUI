//
//  EndpointProtocol.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [String: String] { get }
}

extension EndpointProtocol {
    
    var scheme: String {
        return "https"
    }
}

//
//  String+capitalized.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 21.11.2023.
//

import Foundation

extension String {
    
    var capitalizingFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }
}

//
//  Date+ConvertToString.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 22.11.2023.
//

import Foundation

extension Date {
    
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }
    
    var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

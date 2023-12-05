//
//  WeatherService.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation

class WeatherService {
    
    private let apiService = ApiService()

    func getWeather(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getCurrentWeather(lat: lat, lon: lon), completion: completion)
    }
    
    func getForecast(lat: Double, lon: Double, completion: @escaping (Result<ForecastModel, Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getForecast(lat: lat, lon: lon), completion: completion)
    }
    
    func getCity(name: String, completion: @escaping (Result<[City], Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getCity(name: name), completion: completion)
    }
}

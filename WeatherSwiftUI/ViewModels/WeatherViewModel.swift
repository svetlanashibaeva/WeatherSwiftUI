//
//  WeatherViewModel.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 23.11.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeather?
    @Published var cityName = "" {
        didSet {
            loadData(city: cityName)
        }
    }
    @Published var cityList = [City]()
    private let weatherService = WeatherService()
    
    func loadData(city: String?) {
        var responseError: String?
        
        guard let city = city, !city.isEmpty else {
            cityList = []
            return
        }
        
        weatherService.getCity(name: city) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.cityList = response
                }
            case let .failure(error):
                responseError = error.localizedDescription
//                DispatchQueue.main.async {
//                    self.showError(error: error.localizedDescription)
//                }
            }
        }
    }
}

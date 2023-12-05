//
//  WeatherViewModel.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 23.11.2023.
//

import Foundation
import CoreData

final class WeatherViewModel: ObservableObject {
    
    typealias CityWeather = (CityEntity, CurrentWeather?)
    typealias SearchCity = (City, Bool)
    
    @Published var currentWeather: CurrentWeather?
    
    @Published var cityName = "" {
        didSet {
            searchCity(city: cityName)
        }
    }
    @Published var cityList = [SearchCity]()
    @Published var savedCities = [CityWeather]()
    @Published var isSaved = false
    @Published var isError = false
    var responseError: String?
    
    private let weatherService = WeatherService()
    
    func searchCity(city: String?) {
        responseError = nil
        
        guard let city = city, !city.isEmpty else {
            cityList = []
            return
        }
        
        weatherService.getCity(name: city) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    var arr = [SearchCity]()
                    response.forEach { city in
                        arr.append((
                            city,
                            self.savedCities.contains(where: { cityEntity, _ in
                                cityEntity.id == city.id
                            })
                        ))
                    }
                
                    self.cityList = arr
                }
            case let .failure(error):
                responseError = error.localizedDescription
                DispatchQueue.main.async {
                    self.isError = true
                }
            }
        }
    }
    
    func loadForecastForCity(savedCities: [CityEntity]) {
        
        var array = [CityWeather]()
        
        let taskLoadData = DispatchGroup()
        
        for city in savedCities {
            taskLoadData.enter()
            weatherService.getWeather(lat: city.lat, lon: city.lon) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(response):
                    array.append(CityWeather(city, response))
                case let .failure(error):
                    responseError = error.localizedDescription
                    array.append(CityWeather(city, nil))
                }
                taskLoadData.leave()
            }
        }

        taskLoadData.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self else { return }
            self.savedCities = array
            
            if responseError != nil {
                isError = true
            }
        }
    }
    
    func getSavedCitiesForecast() {
        let saved = (try? CoreDataService.shared.viewContext.fetch(CityEntity.fetchRequest())) ?? []
        savedCities = saved.map { CityWeather($0, nil) }
        loadForecastForCity(savedCities: saved)
    }
    
    func saveCity(city: City) {
        CityEntity.save(from: city)
        CoreDataService.shared.saveContext()
        getSavedCitiesForecast()
    }
}

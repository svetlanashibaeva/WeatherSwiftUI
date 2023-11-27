//
//  HomeViewModel.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 16.11.2023.
//

import Foundation
import CoreLocation


final class HomeViewModel: NSObject, ObservableObject {
    
    @Published var mainWeather: MainWeather?
    @Published var city: City?
    @Published var currentWeather: CurrentWeather?
    @Published var forecast: ForecastModel?
    
    var location: CLLocation?
    private let weatherService = WeatherService()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        if (CLLocationManager.locationServicesEnabled()) {
//        }
    }
    
    private func loadData(lat: Double, lon: Double, name: String) {
        var responseError: String?
        
        let taskLoadData = DispatchGroup()
        taskLoadData.enter()
        weatherService.getWeather(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.currentWeather = response
                    self.mainWeather = self.currentWeather?.main
                }
            case let .failure(error):
                responseError = error.localizedDescription
            }
            
            taskLoadData.leave()
        }
        
        taskLoadData.enter()
        weatherService.getForecast(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self?.forecast = response
                }                
            case let .failure(error):
                responseError = error.localizedDescription
            }
            
            taskLoadData.leave()
        }
        
//        taskLoadData.notify(queue: DispatchQueue.main) { [weak self] in
//            guard let self = self else { return }
//            
//            if let responseError = responseError {
//                self.showError(error: responseError)
//            }
//            
//        }
    }
    
    func setCityName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first,
                  let cityName = placemark.locality
            else { return }
            self?.city = City(name: cityName, localNames: nil, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self?.loadData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, name: cityName)
        }
    }
}

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        setCityName(from: location)
        self.location = location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.authorizationStatus // показывать заглушку с настройками если .denied
    }
}

//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 15.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    
//    var searchResults: [Forecast] {
//        if searchText.isEmpty {
//            return Forecast.cities
//        } else {
//            return Forecast.cities.filter { $0.location.contains(searchText) }
//        }
//    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            // MARK: Weather widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(viewModel.cityList, id: \.self) { city in
                        SearchCell(city: city.name)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            NavigationBar(searchText: $viewModel.cityName)
        }
        .navigationBarHidden(true)
//        .searchable(text: $viewModel.cityName, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView()
                .preferredColorScheme(.dark)
        }
    }
}

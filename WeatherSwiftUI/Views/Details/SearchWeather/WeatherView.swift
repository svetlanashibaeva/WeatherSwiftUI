//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 15.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
 
            // MARK: Weather widgets
            List{
                if viewModel.cityName.isEmpty {
                    ForEach(viewModel.savedCities, id: \.0.id) { element in
                        WeatherWidget(cityName: element.0.name, currentWeather: element.1)
                    }
                    .onDelete(perform: deleteCity)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                } else {
                    ForEach(viewModel.cityList, id: \.0.id) { city in
                        SearchCell(
                            city: city.0.name,
                            isSaved: city.1,
                            action: {
                                viewModel.saveCity(city: city.0)
                                viewModel.cityName = ""
                            })
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(.top, -50)
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
            .alert(viewModel.responseError ?? "", isPresented: $viewModel.isError, actions: {
                Button("Ok") {}
            })
        }
        .overlay {
            NavigationBar(searchText: $viewModel.cityName)
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getSavedCitiesForecast()
        }
    }
}

private extension WeatherView {
    func deleteCity(offsets: IndexSet) {
        offsets.map { viewModel.savedCities[$0].0 }.forEach(CoreDataService.shared.viewContext.delete)
        
        CoreDataService.shared.saveContext()
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

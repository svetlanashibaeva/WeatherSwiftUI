//
//  WeatherWidget.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 15.11.2023.
//

import SwiftUI

struct WeatherWidget: View {
    let cityName: String
    let currentWeather: CurrentWeather?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 174)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(String(format: "%.1f", currentWeather?.main.temp ?? 0.0) + "°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text("H:" + String(format: "%.1f", currentWeather?.main.tempMax ?? 0.0) + "°")
                            
                            Text("L:" + String(format: "%.1f", currentWeather?.main.tempMin ?? 0.0) + "°")
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        
                        Text(cityName)
                            .font(.body)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Image("\(currentWeather?.weather.first?.main.imageName ?? "") large")
                        .padding(.trailing, 4)
                    
                    Text(currentWeather?.weather.first?.description.capitalizingFirstLetter ?? "")
                        .font(.footnote)
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding([.bottom, .leading], 20.0)
        }
        .frame(width: 342, height: 184, alignment: .bottom)
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidget(cityName: "Moscow", currentWeather: nil)
            .preferredColorScheme(.dark)
    }
}

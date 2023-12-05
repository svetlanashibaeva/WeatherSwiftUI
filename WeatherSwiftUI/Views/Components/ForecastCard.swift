//
//  ForecastCard.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 15.11.2023.
//

import SwiftUI

struct ForecastCard: View {
    let forecast: ForecastList
    let forecastPeriod: ForecastPeriod
    
    var isActive: Bool {
        if forecastPeriod == ForecastPeriod.hourly {
            let isHour = Calendar.current.isDate(.now, equalTo: forecast.dt, toGranularity: .hour)
            return isHour
        } else {
            let isToday = Calendar.current.isDate(.now, equalTo: forecast.dt, toGranularity: .day)
            return isToday
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 60, height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            VStack(spacing: 16) {
                Text(forecast.dt, format: forecastPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.subheadline.weight(.semibold))
                
                Image("\(forecast.weather.first?.main.imageName ?? "") small")
                
                Text(String(format: "%.1f", forecast.main.temp.rounded()) + "°")
                    .font(.footnote.weight(.bold))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 60, height: 146)
        }
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(forecast: ForecastList(main: MainWeather(temp: 12.0, feelsLike: 22.0, tempMin: 12.0, tempMax: 22.0, humidity: 64, pressure: 1000), dt: Date(), weather: []), forecastPeriod: .hourly)
    }
}

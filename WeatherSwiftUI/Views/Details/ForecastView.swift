//
//  ForecastView.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 14.11.2023.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    let forecast: [ForecastList]
    let currentWeather: CurrentWeather?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Segmented control
                SegmentedControl(selection: $selection)
                
                // MARK: Forecast card
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        if selection == 0 {
                            ForEach(forecast.prefix(8), id: \.self) { forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                            }
                            .transition(.offset(x: -430))
                        } else {
                            ForEach(dailyForecast(list: forecast), id: \.self) { forecast in
                                ForecastCard(forecast: forecast, forecastPeriod: .weekly)
                            }
                            .transition(.offset(x: 430))
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
                
                // MARK: Forecast Widgets
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        WidgetCard(
                            title: "feels Like",
                            value: String(currentWeather?.main.feelsLike ?? 0.0) + "°",
                            description: "Perception of weather for human"
                        )
                        
                        WidgetCard(
                            title: "humidity",
                            value: String(currentWeather?.main.humidity ?? 0.0) + " %",
                            description: "Humidity"
                        )
                    }
                    
                    HStack(spacing: 16) {
                        WidgetCard(
                            title: "pressure",
                            value: String(currentWeather?.main.pressure ?? 0.0) + " hPa",
                            description: "Atmospheric pressure on the sea level"
                        )
                        
                        WidgetCard(
                            title: "wind",
                            value: String(currentWeather?.wind.speed ?? 0.0) + " m/sec",
                            description: "Wind speed"
                        )
                    }
                }
                .opacity(bottomSheetTranslationProrated)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            // MARK: Separator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: Drag indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    func dailyForecast(list: [ForecastList]) -> [ForecastList] {
        guard let firstInterval = list.first else { return [] }
        
        var daily = [ForecastList]()
        var date = firstInterval.dt
        
        var max = firstInterval.main.tempMax
        var min = firstInterval.main.tempMin
        
        for index in 1...list.count - 1 {
            let interval = list[index]
            
            let isDateEqual = date.weekday == interval.dt.weekday
            let isListEnded = index == list.count - 1
            
            if isDateEqual || isListEnded {
                if interval.main.tempMax > max {
                    max = interval.main.tempMax
                }
                
                if interval.main.tempMin < min {
                    min = interval.main.tempMin
                }
            }
            
            if !isDateEqual || isListEnded {
                daily.append(ForecastList(
                    main: MainWeather(
                        temp: (max + min) / 2,
                        feelsLike: interval.main.feelsLike,
                        tempMin: min,
                        tempMax: max,
                        humidity: interval.main.humidity,
                        pressure: interval.main.pressure
                    ),
                    dt: date,
                    weather: [
                        WeatherDescription(
                            main: interval.weather.first?.main ?? .clear,
                        description: interval.weather.description)
                    ]))
                
                date = interval.dt
                min = interval.main.tempMin
                max = interval.main.tempMax
            }
        }
        return daily
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(forecast: [], currentWeather: nil)
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}

//
//  HomeView.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 13.11.2023.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
//        if let mainWeather = viewModel.mainWeather {
//            mainView(mainWeather: mainWeather)
//        } else {
//            Text("Loading")
//        }
        mainView()
    }
    
    var attributedString: AttributedString {
        guard let weather = viewModel.mainWeather else { return ""}
        
        var string = AttributedString("\(weather.temp.rounded())°" + (hasDragged ? " | " : "\n ") + "\(viewModel.currentWeather?.weather.first?.description.capitalizingFirstLetter ?? "")")
        
        if let temp = string.range(of: "\(weather.temp.rounded())°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: viewModel.currentWeather?.weather.first?.description.capitalizingFirstLetter ?? "") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
    
    private func mainView() -> some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                ZStack {
                    Color.background
                        .ignoresSafeArea()
                    
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text(viewModel.city?.name ?? "")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                                .multilineTextAlignment(.center)
                            
                            Text(tempTitle)
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    
                    // MARK: Bottom sheet
                    BottomSheetView(position: $bottomSheetPosition) {
                        //                    Text(bottomSheetPosition.rawValue.formatted())
                    } content: {
                        ForecastView(
                            bottomSheetTranslationProrated: bottomSheetTranslationProrated,
                            forecast: viewModel.forecast?.list ?? [],
                            currentWeather: viewModel.currentWeather
                        )
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            hasDragged = bottomSheetPosition == BottomSheetPosition.top ? true : false
                        }
                    }
                    
                    // MARK: Tab bar
                    TabBar(action: {
                        bottomSheetPosition = .top
//                        guard let location = viewModel.location else { return }
//                        viewModel.setCityName(from: location)
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var tempTitle: String {
        guard let mainWeather = viewModel.mainWeather else { return "" }
        
        return "H: \(mainWeather.tempMax.rounded())° L: \(mainWeather.tempMin.rounded())°"
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

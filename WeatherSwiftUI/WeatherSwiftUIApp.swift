//
//  WeatherSwiftUIApp.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 13.11.2023.
//

import SwiftUI

@main
struct WeatherSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataService.shared.viewContext)
        }
    }
}

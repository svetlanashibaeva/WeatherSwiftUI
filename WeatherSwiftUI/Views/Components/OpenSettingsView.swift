//
//  OpenSettingsView.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 01.12.2023.
//

import SwiftUI

struct OpenSettingsView: View {

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 342, height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .strokeBorder(.white)
                        .blendMode(.overlay)
                }
            
            VStack(alignment: .leading) {
                
                Text("Allow the application to get your current position")
                    .font(.subheadline.weight(.semibold))
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } label: {
                    Text("Open settings")
                }

            }
            .padding(16)
            .frame(width: 342, height: 100, alignment: .topLeading)
            
        }
    }
}

struct OpenSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSettingsView()
    }
}

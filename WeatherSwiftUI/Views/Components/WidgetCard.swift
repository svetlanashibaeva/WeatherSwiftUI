//
//  WidgetCard.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 23.11.2023.
//

import SwiftUI

struct WidgetCard: View {
    var title: String
    var value: String
    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 164, height: 164)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .strokeBorder(.white)
                        .blendMode(.overlay)
                }
            
            VStack(alignment: .leading) {
                
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.title2.weight(.semibold))
                    .padding(.top, 4)
                
                Spacer()
                
                Text(description)
                    .font(.footnote.weight(.semibold))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 164, height: 164, alignment: .topLeading)
            
        }
    }
}

struct WidgetCard_Previews: PreviewProvider {
    static var previews: some View {
        WidgetCard(
            title: "Feels like",
            value: "19°",
            description: "Similar to the actual temperature"
        )
    }
}

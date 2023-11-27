//
//  SearchCell.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 23.11.2023.
//

import SwiftUI

struct SearchCell: View {
    var city: String
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 342, height: 54)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .strokeBorder(.white)
                        .blendMode(.overlay)
                }
            
            HStack {
                Text(city)
                    .font(.body)
                    .lineLimit(1)
                
                Spacer()

                Button {
                    // сохранить в бд
                } label: {
                    Image(systemName: "plus")
                }
                .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .frame(width: 342, height: 54)
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(city: "Ekaterinburg")
    }
}

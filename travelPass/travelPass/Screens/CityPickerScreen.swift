//
//  CityPickerScreen.swift
//  travelPass
//
//  Created by Игнат Рогачевич on 22.11.25.
//

import SwiftUI

struct CityPickerScreen: View {
    @State var searchString: String = ""
    @State var cities = ["Москва", "Санкт-Петербург", "Сочи", "Краснодар"]
    
    var body: some View {
        VStack {
            TextField("Введите запрос", text: $searchString)
                .textFieldStyle(.plain)
                .font(.system(size: 17,weight: .regular))
                .padding(.horizontal, 30)
                .frame(height: 36)
                .background(.yLightGray)
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.yGray)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        if !searchString.isEmpty {
                            Button(action:clearTextField) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.yGray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 16)
                
        }
        
        
        
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(cities, id: \.self) { city in
                    HStack{
                        Text(city)
                            .foregroundStyle(.primary)
                            .font(.system(size: 16,weight: .regular))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.yBlack)
                            .font(.system(size: 14))
                    }
                    .padding(.horizontal,16)
                    .padding(.vertical, 12)
                    
                }
            }
            
        }
    }
    private func clearTextField() {
        searchString = ""
    }
}


#Preview {
    CityPickerScreen()
}

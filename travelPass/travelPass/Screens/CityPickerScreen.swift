//
//  CityPickerScreen.swift
//  travelPass
//
//  Created by Игнат Рогачевич on 23.11.25.
//

import SwiftUI

struct CityPickerScreen: View {
    @State private var searchText = ""
    @State private var cities = ["Москва", "Санкт-Петербург", "Сочи", "Краснодар"]
    
    var body: some View {
        SearchableListView(
            title: "Выбор города",
            placeholder: "Введите запрос",
            emptyMessage: "Город не найден",
            searchString: $searchText,
            items: cities,
        ) {
            selectedCity in
            
        }
        .navigationTitle("Выбор города")
    }
}

#Preview {
    CityPickerScreen()
}

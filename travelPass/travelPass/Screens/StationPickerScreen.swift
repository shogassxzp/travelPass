//
//  StationPickerScreen.swift
//  travelPass
//
//  Created by Игнат Рогачевич on 23.11.25.
//

import SwiftUI

struct StationPickerScreen: View {
    @State private var searchText = ""
    @State private var stations = ["Курский вокзал", "Балтийский вокзал", "Ладожский вокзал"]

    var body: some View {
        SearchableListView(
            title: "Выбор станции",
            placeholder: "Введите станцию",
            emptyMessage: "Станция не найдена",
            searchString: $searchText,
            items: stations) {
            selectedStation in
        }
            .navigationTitle("Выбор станции")
    }
}

#Preview {
    StationPickerScreen()
}

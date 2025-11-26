import SwiftUI

struct CityPickerScreen: View {
    let selectedField: MainScreen.FieldType
    @Binding var from: String
    @Binding var to: String
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var cities = ["Москва", "Санкт-Петербург", "Сочи", "Краснодар"]
    @State private var selectedCity: String = ""
    @State private var showingStationPicker = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.yBlack)
                }

                Text("Выбор города")
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity)

                Spacer()
            }
            .padding(.horizontal)

            SearchableListView(
                title: "Выбор города",
                placeholder: "Введите запрос",
                emptyMessage: "Город не найден",
                searchString: $searchText,
                items: cities
            ) { city in
                selectedCity = city

                showingStationPicker = true
            }
        }

        .fullScreenCover(isPresented: $showingStationPicker) {
            StationPickerScreen(
                selectedField: selectedField,
                from: $from,
                to: $to,
                selectedCity: $selectedCity,
                onDismiss: {
                    dismiss()
                }
            )
        }
    }
}

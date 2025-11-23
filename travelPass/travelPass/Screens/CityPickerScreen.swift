import SwiftUI

struct CityPickerScreen: View {
    let selectedField: MainScreen.FieldType
    @Binding var from: String
    @Binding var to: String
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var cities = ["Москва", "Санкт-Петербург", "Сочи", "Краснодар"]
    @State private var selectedCity: String? = nil

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.yBlack)
                    }

                    Text("Выбор города")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.leading, -10)
                        .padding(.vertical)

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
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: Binding(
                get: { selectedCity != nil },
                set: { if !$0 { selectedCity = nil } }
            )) {
                if let city = selectedCity {
                    StationPickerScreen(
                        selectedField: selectedField,
                        selectedCity: city,
                        from: $from,
                        to: $to,
                        onDismiss: { dismiss() }
                    )
                }
            }
        }
    }
}

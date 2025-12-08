import SwiftUI

struct CityPickerScreen: View {
    let selectedField: MainScreen.FieldType
    @Binding var from: String
    @Binding var to: String
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var cities = ["Москва", "Санкт-Петербург", "Сочи", "Краснодар"]
    @State private var navigationPath = [String]()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            SearchableListView(
                title: "Выбор города",
                placeholder: "Введите запрос",
                emptyMessage: "Город не найден",
                searchString: $searchText,
                items: cities
            ) { city in

                navigationPath.append(city)
            }
            .navigationDestination(for: String.self) { city in

                StationPickerScreen(
                    selectedField: selectedField,
                    selectedCity: city,
                    from: $from,
                    to: $to,
                    onDismiss: { dismiss() }
                )
            }
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: Chevron.left)
                            .foregroundStyle(.yBlack)
                            .font(.system(size:17, weight: .semibold))
                    }
                }
            }
        }
    }
}



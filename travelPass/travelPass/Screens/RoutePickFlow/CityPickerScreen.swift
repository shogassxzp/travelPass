import SwiftUI

struct CityPickerScreen: View {
    // MARK: - Properties

    let selectedField: MainScreenViewModel.FieldType
    @Binding var from: String
    @Binding var to: String

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CityPickerViewModel()
    @State private var navigationPath = NavigationPath()

    // MARK: - Initializer

    init(
        selectedField: MainScreenViewModel.FieldType,
        from: Binding<String>,
        to: Binding<String>,
    ) {
        self.selectedField = selectedField
        _from = from
        _to = to
    }

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                SearchableListView(
                    title: "Выбор города",
                    placeholder: "Введите запрос",
                    emptyMessage: "Город не найден",
                    searchString: $viewModel.searchText,
                    items: viewModel.cities.map { $0.title }
                ) { cityName in
                    if let city = viewModel.getCity(by: cityName) {
                        navigationPath.append(city)
                    }
                }
            }
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Settlement.self) { city in
                StationPickerScreen(
                    selectedField: selectedField,
                    selectedCity: city.title,
                    from: $from,
                    to: $to,
                    onDismiss: {
                        dismiss()
                    }
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .task(id: viewModel.searchText) {
                await viewModel.searchCities()
            }
            .task {
                await viewModel.loadPopularCities()
            }
        }
    }
}

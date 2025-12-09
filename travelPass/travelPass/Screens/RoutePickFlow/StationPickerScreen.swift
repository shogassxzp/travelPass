import SwiftUI

struct StationPickerScreen: View {
    // MARK: - Properties

    let selectedField: MainScreenViewModel.FieldType
    let selectedCity: String
    @Binding var from: String
    @Binding var to: String
    let onDismiss: () -> Void

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: StationPickerViewModel

    @State private var searchText = ""

    // MARK: - Initializer

    init(
        selectedField: MainScreenViewModel.FieldType,
        selectedCity: String,
        from: Binding<String>,
        to: Binding<String>,
        onDismiss: @escaping () -> Void
    ) {
        self.selectedField = selectedField
        self.selectedCity = selectedCity
        _from = from
        _to = to
        self.onDismiss = onDismiss

        _viewModel = StateObject(
            wrappedValue: StationPickerViewModel(selectedCity: selectedCity)
        )
    }

    var body: some View {
        SearchableListView(
            title: "Выбор станции",
            placeholder: "Введите станцию",
            emptyMessage: "Станция не найдена",
            searchString: $viewModel.searchText,
            items: viewModel.filterStations().map { $0.title }
        ) { stationName in
            if let station = viewModel.getStation(by: stationName) {
                selectStation(station)
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: Chevron.left)
                        .foregroundStyle(.yBlack)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
        .task {
            await viewModel.loadStations()
        }
    }

    // MARK: - Private Methods

    private func selectStation(_ station: Station) {
        let fullText = "\(selectedCity) (\(station.title))"

        switch selectedField {
        case .from:
            from = fullText
        case .to:
            to = fullText
        }

        onDismiss()
    }
}

import SwiftUI

struct StationPickerScreen: View {
    let selectedField: MainScreen.FieldType
    let selectedCity: String
    @Binding var from: String
    @Binding var to: String
    let onDismiss: () -> Void
    
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var stations = ["Курский вокзал", "Балтийский вокзал", "Ладожский вокзал"]

    var body: some View {
        SearchableListView(
            title: "Выбор станции",
            placeholder: "Введите станцию",
            emptyMessage: "Станция не найдена",
            searchString: $searchText,
            items: stations
        ) { station in
            let fullText = "\(selectedCity) (\(station))"
            switch selectedField {
            case .from:
                from = fullText
            case .to:
                to = fullText
            }
            onDismiss()
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {dismiss()}) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

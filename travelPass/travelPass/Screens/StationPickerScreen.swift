import SwiftUI

struct StationPickerScreen: View {
    let selectedField: MainScreen.FieldType
    @Binding var from: String
    @Binding var to: String
    @Binding var selectedCity: String

    let onDismiss: () -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var stations = ["Курский вокзал", "Балтийский вокзал", "Ладожский вокзал"]

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.yBlack)
                }

                Text("Выбор станции")
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity)

                Spacer()
            }
            .padding(.horizontal)

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
        }
    }
}

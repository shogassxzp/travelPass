import SwiftUI

struct FiltersScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var carrierRoute: [CarrierRoute]

    @State private var selectedTimes: Set<String> = []
    let timeOptions = [
        ("Утро", "06:00 - 12:00"),
        ("День", "12:00 - 18:00"),
        ("Вечер", "18:00 - 00:00"),
        ("Ночь", "00:00 - 06:00"),
    ]

    @State private var showTransfers: String = ""

    var isApplyButtonEnabled: Bool {
        !selectedTimes.isEmpty && !showTransfers.isEmpty
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Время отправления")
                            .font(.system(size: 24, weight: .bold))

                        ForEach(timeOptions, id: \.0) { time in
                            TimeOptionRow(
                                title: time.0,
                                subtitle: time.1,
                                isSelected: selectedTimes.contains(time.0),
                                onToggle: {
                                    if selectedTimes.contains(time.0) {
                                        selectedTimes.remove(time.0)
                                    } else {
                                        selectedTimes.insert(time.0)
                                    }
                                }
                            )
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Показывать варианты с пересадками")
                            .font(.system(size: 24, weight: .bold))

                        TransferOptionRow(
                            title: "Да",
                            isSelected: showTransfers == "yes",
                            onSelect: { showTransfers = "yes" }
                        )

                        TransferOptionRow(
                            title: "Нет",
                            isSelected: showTransfers == "no",
                            onSelect: { showTransfers = "no" }
                        )
                    }
                }
                .padding()
            }

            if isApplyButtonEnabled {
                Button("Применить") {
                    carrierRoute.removeLast()
                }
                .foregroundStyle(.white)
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(.blue)
                .cornerRadius(16)
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }
}

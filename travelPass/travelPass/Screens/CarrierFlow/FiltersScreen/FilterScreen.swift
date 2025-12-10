import SwiftUI

struct FiltersScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var filtersViewModel: FiltersViewModel
    @State private var showTransfers: String = ""
    let onApply: () -> Void

    init(
        filtersViewModel: FiltersViewModel = FiltersViewModel(),
        onApply: @escaping () -> Void = {}
    ) {
        self.filtersViewModel = filtersViewModel
        self.onApply = onApply
    }

    var body: some View {
        VStack {
            headerView

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    timeSection
                    transfersSection
                }
                .padding()
            }
            applyButton
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Subviews

    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .font(.title2)
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    private var timeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))

            ForEach(filtersViewModel.timeOptions, id: \.0) { time in
                TimeOptionRow(
                    title: time.0,
                    subtitle: time.1,
                    isSelected: filtersViewModel.selectedTimes.contains(time.0),
                    onToggle: {
                        if filtersViewModel.selectedTimes.contains(time.0) {
                            filtersViewModel.selectedTimes.remove(time.0)
                        } else {
                            filtersViewModel.selectedTimes.insert(time.0)
                        }
                    }
                )
            }
        }
    }

    private var transfersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Показывать варианты с пересадками")
                .font(.system(size: 24, weight: .bold))

            TransferOptionRow(
                title: "Да",
                isSelected: showTransfers == "yes",
                onSelect: {
                    showTransfers = "yes"
                }
            )

            TransferOptionRow(
                title: "Нет",
                isSelected: showTransfers == "no",
                onSelect: {
                    showTransfers = "no"
                }
            )
        }
    }

    private var applyButton: some View {
        Group {
            if filtersViewModel.isApplyButtonEnabled {
                Button("Применить") {
                    onApply()
                    dismiss()
                }
                .foregroundStyle(.white)
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(.blue)
                .cornerRadius(16)
                .padding()
            }
        }
    }
}

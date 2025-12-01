import SwiftUI

struct MainScreen: View {
    @State var from = "Откуда"
    @State var to = "Куда"
    @State var showingCityPicker = false
    @State var showingCarrierList = false
    @State var selectedField: FieldType? = nil

    enum FieldType {
        case from, to
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        selectedField = .from
                        showingCityPicker = true
                    }) {
                        Text(from)
                            .lineLimit(1)
                            .foregroundStyle(from == "Откуда" ? .yGray : .yUniversalBlack)
                            .font(.system(size: 17, weight: .regular))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button(action: {
                        selectedField = .to
                        showingCityPicker = true
                    }) {
                        Text(to)
                            .lineLimit(1)
                            .foregroundStyle(to == "Куда" ? .yGray : .yUniversalBlack)
                            .font(.system(size: 17, weight: .regular))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .background(.white)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)

                Button(action: { revert() }) {
                    Image(systemName: "arrow.2.squarepath")
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.yBlue)
                        .background(.yUniversalWhite)
                        .cornerRadius(40)
                        .padding(.trailing, 16)
                }
            }
            .background(.yBlue)
            .cornerRadius(20)
            .padding(16)
            .frame(maxWidth: .infinity)

            if from != "Откуда" && to != "Куда" {
                Button(action: {
                    showingCarrierList = true
                }) {
                    Text("Найти")
                        .foregroundStyle(.yUniversalWhite)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: 150, maxHeight: 60)
                .background(.yBlue)
                .cornerRadius(16)
            }
            Spacer()
        }

        .fullScreenCover(isPresented: $showingCityPicker) {
            CityPickerScreen(
                selectedField: selectedField ?? .from,
                from: $from,
                to: $to
            )
        }
        .fullScreenCover(isPresented: $showingCarrierList) {
            CarriersListScreen(from: from, to: to)
        }
        .backgroundStyle(.yWhite)
    }

    private func revert() {
        guard from != "Откуда", to != "Куда" else { return }
        let temp = from
        from = to
        to = temp
    }
}

#Preview {
    MainScreen()
}

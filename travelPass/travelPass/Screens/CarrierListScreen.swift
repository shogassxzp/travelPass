
import SwiftUI

struct CarriersListScreen: View {
    let from: String
    let to: String

    @Environment(\.dismiss) private var dismiss

    @State var showingFilters = false

    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundStyle(.yBlack)
            }
            .padding(.leading, 16)
            Spacer()
        }
        VStack(spacing: 0) {
            Text("\(from) → \(to) ")
                .font(.system(size: 24, weight: .bold))
                .padding(16)

            ScrollView {
                LazyVStack(spacing: 16) {
                    CarrierCell()
                    CarrierCell()
                    CarrierCell()
                    CarrierCell()
                    CarrierCell()
                    CarrierCell()
                    CarrierCell()
                    CarrierCell()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            Button(action: { showingFilters = true }) {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.yUniversalWhite)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
            .background(.yBlue)
            .cornerRadius(16)
            .padding(.horizontal, 10)
            .padding(.bottom, 16)
        }
        .fullScreenCover(isPresented: $showingFilters) {
            FiltersScreen()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CarriersListScreen(from: "Москва", to: "Санкт-Петербург")
}

import SwiftUI

struct CarriersListScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал) ")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)

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
                .padding(.top, 20)
            }
            Button(action: {}) {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.yUniversalWhite)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
            .background(.yBlue)
            .cornerRadius(16)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    CarriersListScreen()
}

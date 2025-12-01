import SwiftUI

struct CarriersListScreen: View {
    let from: String
    let to: String
    @State var carrierRoute = [CarrierRoute]()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack(path: $carrierRoute) {
            VStack(spacing: .zero) {
                Text("\(from) → \(to) ")
                    .font(.system(size: 24, weight: .bold))
                    .padding(16)
                //            Реализовать логику для того чтобы показывать EmptyState
                //            Spacer()
                //            Text("Вариантов нет")
                //                .font(.system(size: 24,weight: .bold))
                //            Spacer()

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(0 ..< 8, id: \.self) { _ in
                            CarrierCell()
                                .onTapGesture {
                                    carrierRoute.append(.carrierDetails("Carrier details"))
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                }
                Button(action: { carrierRoute.append(.filters) }) {
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
            .navigationDestination(for: CarrierRoute.self) { route in
                switch route {
                case .filters:
                    FiltersScreen(carrierRoute: $carrierRoute)
                case .carrierDetails:
                    CarrierDetails(carrierRoute: $carrierRoute)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.yBlack)
                            .font(.system(size:17, weight: .semibold))
                    }
                }
            }
        }
    }
}

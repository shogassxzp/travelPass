import SwiftUI

struct CarrierDetails: View {
    @Binding var carrierRoute: [CarriersListViewModel.CarrierRoute]
    let carrier: Carrier

    var body: some View {
        VStack(alignment: .leading) {
            if let logo = carrier.logo, !logo.isEmpty {
                AsyncImage(url: URL(string: logo)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 120)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
            } else {
                Image(.RZD)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(16)
            }

            VStack(alignment: .leading, spacing: 16) {
                Text(carrier.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.yBlack)
                    .padding(.horizontal, 16)

                if hasAdditionalInfo(carrier) {
                    VStack(alignment: .leading, spacing: 12) {
                        if let email = carrier.email, !email.isEmpty {
                            infoRow(title: "E-mail", value: email)
                        }

                        if let phone = carrier.phone, !phone.isEmpty {
                            infoRow(title: "Телефон", value: phone)
                        }
                    }
                    .padding(.horizontal, 16)
                } else {
                    Text("Дополнительная информация отсутствует")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                }

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { carrierRoute.removeLast() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.yBlack)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }

    private func hasAdditionalInfo(_ carrier: Carrier) -> Bool {
        return (carrier.email?.isEmpty == false) ||
            (carrier.phone?.isEmpty == false) ||
            (carrier.address?.isEmpty == false) ||
            (carrier.url?.isEmpty == false)
    }

    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.yBlack)
            Text(value)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.blue)
        }
    }
}

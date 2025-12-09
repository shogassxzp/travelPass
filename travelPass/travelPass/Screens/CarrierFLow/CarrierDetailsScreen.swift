import SwiftUI

struct CarrierDetails: View {
    @Binding var carrierRoute: [CarrierRoute]
    let carrier: Carrier
    
    // MARK: - Body
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
                // Дефолтное изображение если нет логотипа
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
                
                if let email = carrier.email, !email.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.yBlack)
                        Text(email)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.blue)
                    }
                }
                
                if let phone = carrier.phone, !phone.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.yBlack)
                        Text(phone)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.blue)
                    }
                }
                
                Spacer()
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    carrierRoute.removeLast()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.yBlack)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }
}

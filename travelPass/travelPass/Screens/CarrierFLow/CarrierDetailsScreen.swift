import SwiftUI

struct CarrierDetails: View {
    @Binding var carrierRoute: [CarrierRoute]

    var body: some View {
        VStack(alignment: .leading) {
            Image(.RZD)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(16)

            
            VStack(alignment: .leading,spacing: .zero) {
                Text("ОАО «РЖД»")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.yBlack)
                    .padding(.bottom)
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.yBlack)
                Text("exampleMail")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blue)
                    .padding(.bottom)
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.yBlack)
                Text("+7 999-12-34")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blue)

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
            .padding(16)
            Spacer()
        }
    }
}

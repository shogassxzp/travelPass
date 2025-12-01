import SwiftUI

struct CarrierDetails: View {
    @Binding var carrierRoute: [CarrierRoute]

    var body: some View {
        Text("Carrier details")
        Button(action: { carrierRoute.removeLast() }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(.yBlack)
                .font(.system(size:17, weight: .semibold))
        }
        .navigationBarBackButtonHidden(true)
    }
}

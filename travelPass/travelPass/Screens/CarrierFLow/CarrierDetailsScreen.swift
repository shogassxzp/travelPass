import SwiftUI

struct CarrierDetails: View {
    @Binding var carrierRoute: [CarrierRoute]
    
    var body: some View {
        Text("Carrier details")
        Button(action: {carrierRoute.removeLast()}) {
            Image(systemName: "chevron.left")
        }
        .navigationBarBackButtonHidden(true)
    }
}



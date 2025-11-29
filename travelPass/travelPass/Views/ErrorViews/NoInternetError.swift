import SwiftUI

struct NoInternetError: View {
    var body: some View {
        let idealHeight: Double = 223
        let minHeight: Double = 180
        let maxHeight: Double = 250
        let cornerRadius: CGFloat = 70

        Image("NoInternet")
            .resizable()
            .scaledToFit()
            .frame(minWidth: minHeight, minHeight: minHeight,
                   idealHeight: idealHeight, maxHeight: maxHeight)
            .cornerRadius(cornerRadius)
        Text("No internet")
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    NoInternetError()
}

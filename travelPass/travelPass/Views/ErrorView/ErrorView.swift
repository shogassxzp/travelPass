import SwiftUI

struct ErrorView: View {
    let type: ErrorType
    var body: some View {
        let idealHeight: Double = 223
        let minHeight: Double = 180
        let maxHeight: Double = 250
        let cornerRadius: CGFloat = 70

        Image(type.imageName)
            .resizable()
            .scaledToFit()
            .frame(minWidth: minHeight, minHeight: minHeight,
                   idealHeight: idealHeight, maxHeight: maxHeight)
            .cornerRadius(cornerRadius)
        Text(type.title)
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    ErrorView(type: .server)
}

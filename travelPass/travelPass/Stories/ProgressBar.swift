import SwiftUI

struct ProgressBar: View {
    let progress: CGFloat
    let isActive: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 1.5)
                    .fill(Color.yUniversalWhite.opacity(0.3))
                    .frame(height: 6)

                RoundedRectangle(cornerRadius: 1.5)
                    .fill(isActive ? Color.yUniversalWhite : Color.yBlue)
                    .frame(width: geometry.size.width * progress, height: 6)
            }
        }
        .frame(height: 6)
    }
}

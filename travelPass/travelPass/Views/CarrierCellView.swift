import SwiftUI

struct CarrierCell: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                    Text("РЖД")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.yUniversalBlack)

                    Spacer()

                    Text("14 января")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.yUniversalBlack)
                }

                HStack(spacing: 8) {
                    Text("22:30")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.yUniversalBlack)

                    Rectangle()
                        .fill(Color.yGray)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    Text("20 часов")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.yUniversalBlack)

                    Rectangle()
                        .fill(Color.yGray)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    Text("08:15")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.yUniversalBlack)
                }
            }
        }
        .padding()
        .background(Color.yLightGray)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    CarrierCell()
}

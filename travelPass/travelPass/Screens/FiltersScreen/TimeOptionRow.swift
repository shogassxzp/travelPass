import SwiftUI

struct TimeOptionRow: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.yBlack)
                Text(subtitle)
                    .font(.system(size: 17,weight: .regular))
                    .foregroundColor(.yBlack)
            }
            
            Spacer()
            
            SquareCheckbox(isSelected: isSelected, action: onToggle)
        }
        .padding(.vertical, 8)
    }
}

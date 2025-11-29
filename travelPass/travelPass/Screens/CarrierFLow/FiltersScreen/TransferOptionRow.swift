import SwiftUI

struct TransferOptionRow: View {
    let title: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))

            Spacer()

            RadioButton(isSelected: isSelected, action: onSelect)
        }
        .padding(.vertical, 8)
    }
}

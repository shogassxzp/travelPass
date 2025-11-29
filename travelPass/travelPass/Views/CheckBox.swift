import SwiftUI

struct SquareCheckbox: View {
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .foregroundStyle(isSelected ? .yBlack : .yBlack)
                .font(.system(size: 22))
        }
    }
}

struct RadioButton: View {
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isSelected ? "record.circle" : "circle")
                .foregroundStyle(isSelected ? .yBlack : .yBlack)
                .font(.system(size: 22))
        }
    }
}

#Preview {
    RadioButton(isSelected: true, action: {})
}

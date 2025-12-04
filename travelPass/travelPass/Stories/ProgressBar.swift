// ProgressBar.swift
import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 3
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(Color.yUniversalWhite)
                
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.yBlue)
                    .animation(.linear(duration: 0.1), value: progress)
            }

            .mask {
                HStack(spacing: 2) {
                    ForEach(0..<numberOfSections, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                            .frame(height: .progressBarHeight)
                    }
                }
            }
        }
        .frame(height: .progressBarHeight)
    }
}

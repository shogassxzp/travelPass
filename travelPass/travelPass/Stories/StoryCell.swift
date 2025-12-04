import SwiftUI

struct StoryCell: View {
    let story: Story
    let width: CGFloat = 90
    let height: CGFloat = 140
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        story.isViewed ? Color.clear : Color.blue,
                        lineWidth: 4
                    )
                    .frame(width: width, height: height)
                    .cornerRadius(16)

                Image(story.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width - 4, height: height - 4)
                    .cornerRadius(14)
                    .overlay {
                        if story.isViewed {
                            Color.gray.opacity(0.5)
                                .cornerRadius(16)
                        }
                    }
            }
            Text(story.title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.yUniversalWhite)
                .lineLimit(3)
        }
    }
}

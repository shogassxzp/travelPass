import SwiftUI

struct StoryCell: View {
    let story: Story
    let width: CGFloat = 90
    let height: CGFloat = 140
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    story.isViewed ? Color.clear : Color.blue,
                    lineWidth: 8
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

            VStack {
                Spacer()
                HStack {
                    Text(story.title)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 12)
                    Spacer()
                }
            }
            .frame(idealWidth: width, idealHeight: height)
        }
    }
}

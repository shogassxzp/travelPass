import SwiftUI

struct StoryView: View {
    let story: Story
    var body: some View {
        ZStack {
            Image(story.backgroundImage)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .cornerRadius(40)
            
            VStack(alignment: .leading, spacing: 12) {
                Spacer()
                Text(story.title)
                    .font(.system(size: 38,weight: .bold))
                    .foregroundStyle(.yUniversalWhite)
                Text(story.description)
                    .font(.system(size: 20,weight: .regular))
                    .foregroundStyle(.yUniversalWhite)
            }
            .padding(.horizontal,16)
            .padding(.bottom,60)
        }
    }
}


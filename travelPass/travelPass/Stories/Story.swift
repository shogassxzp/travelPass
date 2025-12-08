import SwiftUI


enum StoryConstants {
    static let title = "Text Text Text Text Text Text Text Text Text Text"
    static let description =
        "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
}

struct Story: Identifiable {
    let id = UUID()
    let backgroundImage: String
    let title: String
    let description: String
    var isViewed: Bool = false

    static let stories: [Story] = (1...8).map { index in
    Story(
        backgroundImage:"Story\(index)",
        title: StoryConstants.title,
        description: StoryConstants.description
    )
    }
}

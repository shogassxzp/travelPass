import SwiftUI

struct Story: Identifiable {
    let id = UUID()
    let backgroundImage: String
    let title: String
    let description: String
    var isViewed: Bool = false

    static let stories: [Story] = [
        Story(
            backgroundImage: "Story1",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story2",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story3",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story4",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story5",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story6",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story7",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story8",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
        Story(
            backgroundImage: "Story9",
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        ),
    ]
}

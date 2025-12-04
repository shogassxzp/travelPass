import SwiftUI

struct MainScreen: View {
    @State var from = "From"
    @State var to = "To"
    @State var showingCityPicker = false
    @State var showingCarrierList = false
    @State var selectedField: FieldType? = nil
    @State var showStories = false
    @State var selectedStoryIndex = 0
    
    @State private var stories = Story.stories
    
    enum FieldType {
        case from, to
    }

    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(140))],spacing: 12) {
                    ForEach(Array(stories.enumerated()),id: \.element.id) { index, story in
                        Button(action: {
                        selectedStoryIndex = index
                            stories[index].isViewed = true
                            showStories = true
                        }) {
                            StoryCell(story: story)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom,20)
            }
            
            HStack {
                VStack {
                    Button(action: {
                        selectedField = .from
                        showingCityPicker = true
                    }) {
                        Text(from)
                            .lineLimit(1)
                            .foregroundStyle(from == "From" ? .yGray : .yUniversalBlack)
                            .font(.system(size: 17, weight: .regular))
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button(action: {
                        selectedField = .to
                        showingCityPicker = true
                    }) {
                        Text(to)
                            .lineLimit(1)
                            .foregroundStyle(to == "To" ? .yGray : .yUniversalBlack)
                            .font(.system(size: 17, weight: .regular))
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .background(.white)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)

                Button(action: { revert() }) {
                    Image(systemName: "arrow.2.squarepath")
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.yBlue)
                        .background(.yUniversalWhite)
                        .cornerRadius(40)
                        .padding(.trailing, 16)
                }
            }
            .background(.yBlue)
            .cornerRadius(20)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity)

            if from != "From" && to != "To" {
                Button(action: {
                    showingCarrierList = true
                }) {
                    Text("Find")
                        .foregroundStyle(.yWhite)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: 150, maxHeight: 60)
                .background(.yBlue)
                .cornerRadius(16)
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $showStories) {
            StoriesFullScreenView(
                stories: $stories,
                currentIndex: $selectedStoryIndex,
                isPresented: $showStories
            )
        }
        .fullScreenCover(isPresented: $showingCityPicker) {
            CityPickerScreen(
                selectedField: selectedField ?? .from,
                from: $from,
                to: $to
            )
        }
        .fullScreenCover(isPresented: $showingCarrierList) {
            CarriersListScreen(from: from, to: to)
        }
        .backgroundStyle(.yWhite)
    }
        
    private func revert() {
        guard from != "From", to != "To" else { return }
        let temp = from
        from = to
        to = temp
    }
}

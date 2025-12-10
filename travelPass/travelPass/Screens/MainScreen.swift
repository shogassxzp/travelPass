import SwiftUI

struct MainScreen: View {
    @StateObject private var viewModel = MainScreenViewModel()
    @State var showStories = false
    @State var selectedStoryIndex = 0
    @State private var stories = Story.stories

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            storiesSection

            VStack(spacing: 16) {
                routeSelector
                findButton
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showStories) {
            storiesFullScreen
        }
        .fullScreenCover(isPresented: $viewModel.showingCityPicker) {
            cityPickerScreen
        }
        .fullScreenCover(isPresented: $viewModel.showingCarrierList) {
            carriersListScreen
        }
        .backgroundStyle(.yWhite)
    }

    // MARK: - Subviews

    // Stories Section
    private var storiesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: [GridItem(.fixed(140))],
                    spacing: 12
                ) {
                    ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                        Button(action: {
                            selectStory(at: index)
                        }) {
                            StoryCell(story: story)
                                .frame(width: 90, height: 140)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .frame(height: 180)
        }
    }

    // Route Selector
    private var routeSelector: some View {
        HStack {
            VStack {
                cityButton(
                    text: viewModel.from,
                    isPlaceholder: viewModel.from == "Откуда",
                    fieldType: .from
                )

                cityButton(
                    text: viewModel.to,
                    isPlaceholder: viewModel.to == "Куда",
                    fieldType: .to
                )
            }
            .background(.white)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)

            swapButton
        }
        .background(.yBlue)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }

    // Find Button
    private var findButton: some View {
        Group {
            if viewModel.isFindButtonEnabled {
                Button(action: {
                    Task {
                        let isValid = await viewModel.validateRoute()
                        
                        if isValid {
                            viewModel.showingCarrierList = true
                        } else {
                            print("Маршрут невалиден")
                        }
                    }
                }) {
                    Text("Найти")
                        .foregroundStyle(.yUniversalWhite)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: 150, maxHeight: 60)
                .background(.yBlue)
                .cornerRadius(16)
                .disabled(viewModel.isLoading)
            }
        }
    }

    // FullScreen Views
    private var storiesFullScreen: some View {
        StoriesFullScreenView(
            stories: $stories,
            currentIndex: $selectedStoryIndex,
            isPresented: $showStories
        )
    }

    private var cityPickerScreen: some View {
        CityPickerScreen(
            selectedField: viewModel.selectedField ?? .from,
            from: $viewModel.from,
            to: $viewModel.to
        )
    }

    private var carriersListScreen: some View {
        CarriersListScreen(from: viewModel.from, to: viewModel.to)
    }

    // MARK: - Helper Views

    private func cityButton(text: String, isPlaceholder: Bool, fieldType: MainScreenViewModel.FieldType) -> some View {
        Button(action: {
            viewModel.selectField(fieldType)
        }) {
            Text(text)
                .lineLimit(1)
                .foregroundStyle(isPlaceholder ? .yGray : .yUniversalBlack)
                .font(.system(size: 17, weight: .regular))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var swapButton: some View {
        Button(action: {
            viewModel.revert()
        }) {
            Image(systemName: "arrow.2.squarepath")
                .frame(width: 36, height: 36)
                .foregroundStyle(.yBlue)
                .background(.yUniversalWhite)
                .cornerRadius(40)
                .padding(.trailing, 16)
        }
    }

    // MARK: - Actions

    private func selectStory(at index: Int) {
        selectedStoryIndex = index
        stories[index].isViewed = true
        showStories = true
    }
}

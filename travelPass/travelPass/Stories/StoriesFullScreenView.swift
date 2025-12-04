import Combine
import SwiftUI

struct StoriesFullScreenView: View {
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat

        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.05
        ) {
            self.timerTickInternal = timerTickInternal
            progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        }
    }

    @Binding var stories: [Story]
    @Binding var currentIndex: Int
    @Binding var isPresented: Bool

    private let configuration: Configuration
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?

    init(stories: Binding<[Story]>, currentIndex: Binding<Int>, isPresented: Binding<Bool>) {
        _stories = stories
        _currentIndex = currentIndex
        _isPresented = isPresented

        let storiesCount = stories.wrappedValue.count
        configuration = Configuration(storiesCount: storiesCount)
        timer = Self.createTimer(configuration: configuration)
    }

    private var computedCurrentIndex: Int {
        Int(progress * CGFloat(stories.count))
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if computedCurrentIndex < stories.count {
                StoryView(story: stories[computedCurrentIndex])
            }

            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    ProgressBar(
                        numberOfSections: stories.count,
                        progress: progress
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 60)

                    HStack {
                        Spacer()
                        Button(action: {
                            stopTimer()
                            withAnimation {
                                isPresented = false
                            }
                        }) {
                            Image(.close)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 16)
                    }
                }

                Spacer()
            }
        }
        .onAppear {
            let initialProgress = CGFloat(currentIndex) / CGFloat(stories.count)
            progress = initialProgress

            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
        .onTapGesture { location in
            handleTap(location: location)
        }
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    handleSwipe(translation: gesture.translation)
                }
        )
    }

    private func startTimer() {
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }

    private func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
    }

    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick

        if nextProgress >= 1 {
            stopTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isPresented = false
                }
            }
            return
        }

        let newIndex = Int(nextProgress * CGFloat(stories.count))
        if newIndex != currentIndex {
            currentIndex = newIndex
            stories[currentIndex].isViewed = true
        }

        withAnimation(.linear(duration: configuration.timerTickInternal)) {
            progress = nextProgress
        }
    }

    private func handleTap(location: CGPoint) {
        let screenWidth = UIScreen.main.bounds.width
        let storiesCount = stories.count

        if location.x < screenWidth / 2 {
            let targetIndex = max(computedCurrentIndex - 1, 0)
            withAnimation {
                progress = CGFloat(targetIndex) / CGFloat(storiesCount)
                currentIndex = targetIndex
                if targetIndex < stories.count {
                    stories[targetIndex].isViewed = true
                }
            }
            resetTimer()
        } else {
            if computedCurrentIndex >= storiesCount - 1 {
                stopTimer()
                withAnimation {
                    isPresented = false
                }
            } else {
                let targetIndex = computedCurrentIndex + 1
                withAnimation {
                    progress = CGFloat(targetIndex) / CGFloat(storiesCount)
                    currentIndex = targetIndex
                    if targetIndex < stories.count {
                        stories[targetIndex].isViewed = true
                    }
                }
                resetTimer()
            }
        }
    }

    private func handleSwipe(translation: CGSize) {
        let storiesCount = stories.count

        if translation.width < -50 {
            if computedCurrentIndex >= storiesCount - 1 {
                stopTimer()
                withAnimation {
                    isPresented = false
                }
            } else {
                let targetIndex = computedCurrentIndex + 1
                withAnimation {
                    progress = CGFloat(targetIndex) / CGFloat(storiesCount)
                    currentIndex = targetIndex
                    if targetIndex < stories.count {
                        stories[targetIndex].isViewed = true
                    }
                }
                resetTimer()
            }
        } else if translation.width > 50 {
            let targetIndex = max(computedCurrentIndex - 1, 0)
            withAnimation {
                progress = CGFloat(targetIndex) / CGFloat(storiesCount)
                currentIndex = targetIndex
                if targetIndex < stories.count {
                    stories[targetIndex].isViewed = true
                }
            }
            resetTimer()
        }
    }

    private func resetTimer() {
        stopTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startTimer()
        }
    }

    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

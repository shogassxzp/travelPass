import SwiftUI
import Combine

struct StoriesFullScreenView: View {
    @Binding var stories: [Story]
    @Binding var currentIndex: Int
    @Binding var isPresented: Bool
    
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher?
    @State private var cancellable: Cancellable?
    
    private let storyDuration: TimeInterval = 5
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if currentIndex < stories.count {
                StoryView(story: stories[currentIndex])
            }
            
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    ForEach(0..<stories.count, id: \.self) { index in
                        ProgressBar(
                            progress: index == currentIndex ? progress :
                                     (index < currentIndex ? 1 : 0),
                            isActive: index == currentIndex
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 60)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.trailing, 16)
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
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
    
    private func handleTap(location: CGPoint) {
        let screenWidth = UIScreen.main.bounds.width
        if location.x < screenWidth / 2 {
            previousStory()
        } else {
            nextStory()
        }
        resetTimer()
    }
    
    
    private func handleSwipe(translation: CGSize) {
        if translation.width < -50 {
            
            nextStory()
        } else if translation.width > 50 {
            
            previousStory()
        }
        resetTimer()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
        cancellable = timer?.sink { _ in
            withAnimation(.linear(duration: 0.1)) {
                progress += 0.1 / storyDuration
                if progress >= 1 {
                    nextStory()
                }
            }
        }
    }
    
    private func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    private func resetTimer() {
        stopTimer()
        progress = 0
        startTimer()
    }
    
    private func nextStory() {
        if currentIndex < stories.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentIndex += 1
                stories[currentIndex].isViewed = true
            }
        } else {
            withAnimation {
                isPresented = false
            }
        }
        resetTimer()
    }
    
    private func previousStory() {
        if currentIndex > 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentIndex -= 1
            }
            resetTimer()
        }
    }
}

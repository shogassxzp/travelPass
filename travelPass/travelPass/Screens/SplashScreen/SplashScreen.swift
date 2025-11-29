import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("Splash Screen")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashScreen()
}

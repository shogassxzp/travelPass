import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MainScreen()
            }
            .tabItem {
                Image("Arrow")
            }
            NavigationStack {
                SettingsScreen()
            }
            .tabItem {
                Image("Settings gear")
            }
        }
        .tint(.yBlack)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.yGray)
                .offset(y: -50),
            alignment: .bottom
        )
    }
}

#Preview {
    MainTabView()
}

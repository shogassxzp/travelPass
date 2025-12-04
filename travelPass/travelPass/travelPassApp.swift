import SwiftUI

@main
struct travelPassApp: App {
    @StateObject private var themeManager = ThemeManager.shared
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }
}

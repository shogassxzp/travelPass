import SwiftUI

@main
struct travelPassApp: App {
    @StateObject private var stationService = StationService(apiKey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd")
    @StateObject private var themeManager = ThemeManager.shared
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(themeManager)
                .environmentObject(stationService)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }
}

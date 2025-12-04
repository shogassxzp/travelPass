import SwiftUI
import Combine

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            NotificationCenter.default.post(name: .themeDidChange, object: nil)
        }
    }
    private init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}

extension Notification.Name {
    static let themeDidChange = Notification.Name("themeDidChange")
}

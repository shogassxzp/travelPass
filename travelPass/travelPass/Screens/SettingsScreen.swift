import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var showLicence = false
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 25) {
                Toggle("Тёмная тема", isOn: $themeManager.isDarkMode)
                    .font(.system(size: 17, weight: .regular))
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                Button(action: { showLicence.toggle() }) {
                    Text("Пользовательское соглашение")
                        .foregroundStyle(.yBlack)
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                    Image(systemName: Chevron.right)
                        .font(.system(size: 17,weight: .semibold))
                        .foregroundStyle(.yBlack)
                }
                .foregroundStyle(.black)
                
                Spacer()
                
            }
            .padding()
            Text("Приложение использует API «Яндекс.Расписания»" )
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(.yBlack)
            Text("Версия 1.0 (beta)")
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(.yBlack)
                .padding(.bottom, 24)
        }
        .fullScreenCover(isPresented: $showLicence) {
            LicenceScreen(showLicence: $showLicence)
        }
    }
}

#Preview {
    SettingsScreen()
}

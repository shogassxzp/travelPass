//
//  TabView.swift
//  travelPass
//
//  Created by Игнат Рогачевич on 22.11.25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainScreen()
                .tabItem {
                    Image("Arrow")
                        .foregroundStyle(.yGray)
                        .tint(.yGray)
                        .accentColor(.yBlack)
                        
                }
            SettingsView()
                .tabItem {
                    Image("Settings gear")
                        .tint(.yGray)
                        .accentColor(.yBlack)
                }
        }
    }
}

#Preview {
    MainTabView()
}

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
                }
            SettingsScreen()
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

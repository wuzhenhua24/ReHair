//
//  MainTabView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
                .tag(Tab.home)

            HairstyleGalleryView()
                .tabItem {
                    Label("发型图库", systemImage: "photo.stack.fill")
                }
                .tag(Tab.gallery)

            MyHairstylesView()
                .tabItem {
                    Label("我的发型", systemImage: "heart.fill")
                }
                .tag(Tab.myHairstyles)

            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
                .tag(Tab.profile)
        }
        .accentColor(.blue)
    }
}

// MARK: - Tab Enum
enum Tab {
    case home
    case gallery
    case myHairstyles
    case profile
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}

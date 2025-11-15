//
//  ReHairApp.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

@main
struct ReHairApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(appState)
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    @Published var savedHairstyles: [HairstyleResult] = []

    init() {
        // 初始化应用状态
        loadUserData()
    }

    private func loadUserData() {
        // TODO: 从本地存储加载用户数据
    }

    func saveHairstyle(_ hairstyle: HairstyleResult) {
        savedHairstyles.insert(hairstyle, at: 0)
        // TODO: 持久化存储
    }

    func deleteHairstyle(_ hairstyle: HairstyleResult) {
        savedHairstyles.removeAll { $0.id == hairstyle.id }
        // TODO: 从持久化存储删除
    }
}

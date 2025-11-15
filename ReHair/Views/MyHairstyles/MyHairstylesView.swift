//
//  MyHairstylesView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct MyHairstylesView: View {
    @EnvironmentObject var appState: AppState
    @State private var showClearAlert = false

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            Group {
                if appState.savedHairstyles.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(appState.savedHairstyles) { hairstyle in
                                SavedHairstyleCard(hairstyle: hairstyle)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("我的发型")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if !appState.savedHairstyles.isEmpty {
                        Button(action: {
                            showClearAlert = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .confirmationDialog("清空记录", isPresented: $showClearAlert) {
                Button("清空所有记录", role: .destructive) {
                    appState.savedHairstyles.removeAll()
                }
                Button("取消", role: .cancel) {}
            } message: {
                Text("确定要清空所有保存的发型记录吗?此操作不可恢复。")
            }
        }
    }

    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.textSecondary)

            Text("暂无保存的发型")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.textPrimary)

            Text("在发型效果页面保存你喜欢的发型")
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
    }
}

// MARK: - Saved Hairstyle Card
struct SavedHairstyleCard: View {
    let hairstyle: HairstyleResult
    @EnvironmentObject var appState: AppState
    @State private var showDeleteAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 发型图片占位符
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.primaryBlue.opacity(0.2),
                            Color.blue.opacity(0.4)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .aspectRatio(0.75, contentMode: .fit)
                .overlay(
                    VStack {
                        Image(systemName: hairstyle.style.icon)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        Text(hairstyle.style.displayName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                )
                .overlay(
                    // 删除按钮
                    Button(action: {
                        showDeleteAlert = true
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding(8),
                    alignment: .topTrailing
                )

            // 保存时间
            Text(hairstyle.createdAt.timeAgo())
                .font(.system(size: 12))
                .foregroundColor(.textSecondary)

            // 标签
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(hairstyle.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 10))
                            .foregroundColor(.primaryBlue)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.primaryBlue.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
            }
        }
        .confirmationDialog("删除发型", isPresented: $showDeleteAlert) {
            Button("删除", role: .destructive) {
                appState.deleteHairstyle(hairstyle)
            }
            Button("取消", role: .cancel) {}
        } message: {
            Text("确定要删除这个发型记录吗?")
        }
    }
}

#Preview {
    MyHairstylesView()
        .environmentObject(AppState())
}

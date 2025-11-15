//
//  HairstyleGalleryView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct HairstyleGalleryView: View {
    @State private var selectedCategory: StyleCategory = .hairLossSolution
    @State private var selectedStyle: HairstyleStyle = .hairTransplant
    @State private var galleryItems: [GalleryItem] = []

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 顶部说明
                headerBanner

                // 大分类选择器
                categoryPicker

                // 子分类选择器
                stylePicker

                // 图库网格
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredItems) { item in
                            GalleryItemCard(item: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("效果展示")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadGalleryItems()
            }
        }
    }

    // MARK: - Header Banner
    private var headerBanner: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.primaryBlue)
                Text("真实用户案例 · AI模拟效果")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.textPrimary)
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.primaryBlue.opacity(0.1))
        }
    }

    // MARK: - Category Picker
    private var categoryPicker: some View {
        HStack(spacing: 16) {
            CategoryTab(
                title: "脱发解决方案",
                icon: "cross.case.fill",
                isSelected: selectedCategory == .hairLossSolution
            ) {
                selectedCategory = .hairLossSolution
                selectedStyle = .hairTransplant
            }

            CategoryTab(
                title: "常规发型",
                icon: "scissors",
                isSelected: selectedCategory == .regularStyle
            ) {
                selectedCategory = .regularStyle
                selectedStyle = .short
            }
        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    // MARK: - Style Picker
    private var stylePicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stylesForCurrentCategory, id: \.self) { style in
                    StyleButton(
                        style: style,
                        isSelected: selectedStyle == style
                    ) {
                        selectedStyle = style
                    }
                }
            }
            .padding()
        }
        .background(Color.secondaryGray)
    }

    // MARK: - Filtered Items
    private var filteredItems: [GalleryItem] {
        galleryItems.filter { $0.style == selectedStyle }
    }

    private var stylesForCurrentCategory: [HairstyleStyle] {
        HairstyleStyle.allCases.filter { $0.category == selectedCategory }
    }

    // MARK: - Load Gallery Items
    private func loadGalleryItems() {
        // TODO: 从服务器加载图库数据
        // 这里创建模拟数据
        galleryItems = HairstyleStyle.allCases.flatMap { style in
            (0..<6).map { index in
                GalleryItem(
                    imageURL: "gallery_\(style.rawValue)_\(index)",
                    style: style,
                    tags: getTagsForStyle(style),
                    description: style.description
                )
            }
        }
    }

    private func getTagsForStyle(_ style: HairstyleStyle) -> [String] {
        switch style {
        case .hairTransplant:
            return ["自然", "逼真", "推荐"]
        case .hairlineAdjustment:
            return ["优化脸型", "自然"]
        case .wigSimulation:
            return ["舒适", "自然"]
        case .hairDensity:
            return ["浓密", "自然"]
        default:
            return ["时尚", "推荐"]
        }
    }
}

// MARK: - Category Tab
struct CategoryTab: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : .textSecondary)

                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : .textPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                isSelected ?
                    AnyView(
                        LinearGradient(
                            gradient: Gradient(colors: [.primaryBlue, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ) :
                    AnyView(Color.secondaryGray)
            )
            .cornerRadius(12)
        }
    }
}

// MARK: - Style Button
struct StyleButton: View {
    let style: HairstyleStyle
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: style.icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .white : .textPrimary)

                Text(style.displayName)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(isSelected ? .white : .textPrimary)

                if isSelected {
                    Text(style.description)
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                isSelected ?
                    AnyView(
                        LinearGradient(
                            gradient: Gradient(colors: [.primaryBlue, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    ) :
                    AnyView(Color.white)
            )
            .cornerRadius(12)
            .shadow(color: isSelected ? Color.primaryBlue.opacity(0.3) : Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

// MARK: - Gallery Item Card (Updated)
struct GalleryItemCard: View {
    let item: GalleryItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 图片占位符
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            colorForStyle(item.style).opacity(0.2),
                            colorForStyle(item.style).opacity(0.4)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .aspectRatio(0.75, contentMode: .fit)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: item.style.icon)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        Text(item.style.displayName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                        if item.style.category == .hairLossSolution {
                            Text("真实案例")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(8)
                        }
                    }
                )

            // 描述
            Text(item.description)
                .font(.system(size: 12))
                .foregroundColor(.textSecondary)
                .lineLimit(2)

            // 标签
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(item.tags.prefix(3), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 10))
                            .foregroundColor(colorForStyle(item.style))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(colorForStyle(item.style).opacity(0.1))
                            .cornerRadius(4)
                    }
                }
            }
        }
    }

    private func colorForStyle(_ style: HairstyleStyle) -> Color {
        switch style.category {
        case .hairLossSolution:
            switch style {
            case .hairTransplant: return .green
            case .hairlineAdjustment: return .purple
            case .wigSimulation: return .blue
            case .hairDensity: return .orange
            default: return .primaryBlue
            }
        case .regularStyle:
            return .primaryBlue
        }
    }
}

#Preview {
    HairstyleGalleryView()
}

//
//  HairstyleGalleryView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct HairstyleGalleryView: View {
    @State private var selectedCategory: HairstyleStyle = .short
    @State private var galleryItems: [GalleryItem] = []

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 分类选择器
                categoryPicker

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
            .navigationTitle("发型图库")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadGalleryItems()
            }
        }
    }

    // MARK: - Category Picker
    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(HairstyleStyle.allCases, id: \.self) { style in
                    CategoryButton(
                        style: style,
                        isSelected: selectedCategory == style
                    ) {
                        selectedCategory = style
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    // MARK: - Filtered Items
    private var filteredItems: [GalleryItem] {
        galleryItems.filter { $0.style == selectedCategory }
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
                    tags: ["时尚", "推荐"],
                    description: "\(style.displayName)效果展示"
                )
            }
        }
    }
}

// MARK: - Category Button
struct CategoryButton: View {
    let style: HairstyleStyle
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: style.icon)
                    .font(.system(size: 14))
                Text(style.displayName)
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(isSelected ? .white : .textPrimary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
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
            .cornerRadius(20)
        }
    }
}

// MARK: - Gallery Item Card
struct GalleryItemCard: View {
    let item: GalleryItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 图片占位符
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
                        Image(systemName: item.style.icon)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        Text(item.style.displayName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                )

            // 标签
            HStack(spacing: 4) {
                ForEach(item.tags.prefix(2), id: \.self) { tag in
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
}

#Preview {
    HairstyleGalleryView()
}

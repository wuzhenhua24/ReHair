//
//  HairstyleResultView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct HairstyleResultView: View {
    let originalImage: UIImage
    let results: [HairstyleResult]
    @Binding var isPresented: Bool
    @EnvironmentObject var appState: AppState

    @State private var selectedIndex: Int = 0
    @State private var showComparison: Bool = false
    @State private var comparisonValue: Double = 0.5
    @State private var showSaveAlert: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 上方:原始照片缩略图
                originalImageThumbnail

                // 中部:发型效果卡片
                hairstyleCarousel

                // 底部:操作按钮
                actionButtons
            }
            .navigationTitle("发型效果")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("完成") {
                        isPresented = false
                    }
                }
            }
            .alert("保存成功", isPresented: $showSaveAlert) {
                Button("确定", role: .cancel) {}
            } message: {
                Text("发型已保存到我的发型")
            }
        }
    }

    // MARK: - Original Image Thumbnail
    private var originalImageThumbnail: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("原始照片")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textSecondary)
                .padding(.horizontal)

            Image(uiImage: originalImage)
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
        }
        .padding(.top, 16)
    }

    // MARK: - Hairstyle Carousel
    private var hairstyleCarousel: some View {
        VStack(spacing: 16) {
            TabView(selection: $selectedIndex) {
                ForEach(results.indices, id: \.self) { index in
                    HairstyleCard(
                        result: results[index],
                        showComparison: $showComparison,
                        comparisonValue: $comparisonValue,
                        originalImage: originalImage
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 500)

            // 页面指示器和风格标签
            if !results.isEmpty {
                VStack(spacing: 12) {
                    // 风格名称
                    Text(results[selectedIndex].style.displayName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.textPrimary)

                    // 标签
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(results[selectedIndex].tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 12))
                                    .foregroundColor(.primaryBlue)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.primaryBlue.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }

    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Divider()

            HStack(spacing: 16) {
                // 前后对比按钮
                Button(action: {
                    showComparison.toggle()
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: showComparison ? "eye.slash.fill" : "eye.fill")
                            .font(.system(size: 22))
                        Text(showComparison ? "关闭对比" : "前后对比")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.primaryBlue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.primaryBlue.opacity(0.1))
                    .cornerRadius(12)
                }

                // 保存按钮
                Button(action: {
                    saveCurrentHairstyle()
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 22))
                        Text("保存")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.primaryBlue, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                }

                // 分享按钮
                Button(action: {
                    shareCurrentHairstyle()
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 22))
                        Text("分享")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.primaryBlue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.primaryBlue.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }

    // MARK: - Helper Functions
    private func saveCurrentHairstyle() {
        if !results.isEmpty {
            appState.saveHairstyle(results[selectedIndex])
            showSaveAlert = true
        }
    }

    private func shareCurrentHairstyle() {
        // TODO: 实现分享功能
        print("分享发型")
    }
}

// MARK: - Hairstyle Card
struct HairstyleCard: View {
    let result: HairstyleResult
    @Binding var showComparison: Bool
    @Binding var comparisonValue: Double
    let originalImage: UIImage

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 生成的发型图片(占位符)
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.primaryBlue.opacity(0.3),
                                Color.blue.opacity(0.5)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("生成的发型效果")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            Text(result.style.displayName)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    )

                // 对比模式:原始图片遮罩
                if showComparison {
                    HStack(spacing: 0) {
                        Image(uiImage: originalImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width * comparisonValue)
                            .clipped()

                        Spacer()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // 分割线
                    GeometryReader { geo in
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 3)
                            .offset(x: geo.size.width * comparisonValue)
                            .overlay(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        HStack(spacing: 2) {
                                            Image(systemName: "chevron.left")
                                                .font(.system(size: 12))
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 12))
                                        }
                                        .foregroundColor(.primaryBlue)
                                    )
                                    .offset(x: geo.size.width * comparisonValue, y: geo.size.height / 2)
                            )
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = value.location.x / geometry.size.width
                                comparisonValue = min(max(newValue, 0), 1)
                            }
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    HairstyleResultView(
        originalImage: UIImage(systemName: "photo")!,
        results: [
            HairstyleResult(
                originalImageURL: "original",
                generatedImageURL: "generated1",
                style: .short,
                tags: ["适合圆脸", "清爽"]
            ),
            HairstyleResult(
                originalImageURL: "original",
                generatedImageURL: "generated2",
                style: .korean,
                tags: ["韩系中分", "时尚"]
            )
        ],
        isPresented: .constant(true)
    )
    .environmentObject(AppState())
}

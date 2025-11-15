//
//  HomeView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var photoPickerVM = PhotoPickerViewModel()
    @State private var showPhotoPreprocess = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // 头部标题
                    headerSection

                    // 主功能按钮
                    uploadButton

                    // 案例展示
                    examplesSection

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("发境")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $photoPickerVM.showImagePicker) {
                ImagePicker(
                    image: $photoPickerVM.selectedImage,
                    sourceType: photoPickerVM.imageSourceType
                )
            }
            .confirmationDialog("选择照片来源", isPresented: $photoPickerVM.showActionSheet) {
                Button("拍照") {
                    photoPickerVM.openCamera()
                }
                Button("从相册选择") {
                    photoPickerVM.openPhotoLibrary()
                }
                Button("取消", role: .cancel) {}
            }
            .onChange(of: photoPickerVM.selectedImage) { newImage in
                if newImage != nil {
                    showPhotoPreprocess = true
                }
            }
            .fullScreenCover(isPresented: $showPhotoPreprocess) {
                if let image = photoPickerVM.selectedImage {
                    PhotoPreprocessView(image: image, isPresented: $showPhotoPreprocess)
                }
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 12) {
            Text("欢迎使用发境")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.textPrimary)

            Text("上传照片,查看适合你的发型")
                .font(.system(size: 16))
                .foregroundColor(.textSecondary)
        }
        .padding(.top, 20)
    }

    // MARK: - Upload Button
    private var uploadButton: some View {
        Button(action: {
            photoPickerVM.selectImageSource()
        }) {
            VStack(spacing: 16) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)

                Text("拍照上传")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)

                Text("试试你的专属发型")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.primaryBlue, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: .primaryBlue.opacity(0.3), radius: 15, x: 0, y: 10)
        }
    }

    // MARK: - Examples Section
    private var examplesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("效果展示")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<3) { index in
                        ExampleCard(index: index)
                    }
                }
            }
        }
    }
}

// MARK: - Example Card
struct ExampleCard: View {
    let index: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 图片占位符
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondaryGray)
                .frame(width: 250, height: 300)
                .overlay(
                    VStack {
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(.textSecondary)
                        Text("效果示例 \(index + 1)")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)
                    }
                )

            Text("发型案例 \(index + 1)")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.textPrimary)

            HStack {
                Text("韩系")
                    .font(.system(size: 12))
                    .foregroundColor(.primaryBlue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.primaryBlue.opacity(0.1))
                    .cornerRadius(6)

                Text("自然")
                    .font(.system(size: 12))
                    .foregroundColor(.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(6)
            }
        }
        .cardStyle()
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeView()
}

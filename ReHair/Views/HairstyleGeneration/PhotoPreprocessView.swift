//
//  PhotoPreprocessView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct PhotoPreprocessView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    @State private var showGenerationView = false
    @State private var croppedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 照片预览
                imagePreview

                // 提示文本
                instructionText

                Spacer()

                // 操作按钮
                actionButtons
            }
            .padding()
            .navigationTitle("照片预处理")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        isPresented = false
                    }
                }
            }
            .fullScreenCover(isPresented: $showGenerationView) {
                HairstyleGenerationView(
                    image: croppedImage ?? image,
                    isPresented: $showGenerationView
                )
            }
        }
    }

    // MARK: - Image Preview
    private var imagePreview: some View {
        GeometryReader { geometry in
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primaryBlue, lineWidth: 2)
                )
        }
        .frame(height: 400)
    }

    // MARK: - Instruction Text
    private var instructionText: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.primaryBlue)
                Text("请确保照片包含完整的面部和头部")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
            }

            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("照片会自动裁剪和优化")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
            }
        }
        .padding()
        .background(Color.secondaryGray)
        .cornerRadius(12)
    }

    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 16) {
            // 开始生成按钮
            Button(action: {
                croppedImage = image.cropToSquare()
                showGenerationView = true
            }) {
                Text("开始生成发型")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.primaryBlue, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }

            // 重新上传按钮
            Button(action: {
                isPresented = false
            }) {
                Text("重新上传")
                    .font(.system(size: 16))
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    PhotoPreprocessView(
        image: UIImage(systemName: "photo")!,
        isPresented: .constant(true)
    )
}

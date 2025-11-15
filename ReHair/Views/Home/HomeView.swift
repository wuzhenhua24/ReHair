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
    @State private var showHairLossDetection = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // 头部标题 - 突出脱发解决方案
                    headerSection

                    // 核心功能卡片
                    coreFeatures

                    // 用户痛点说明
                    painPointsSection

                    // 使用场景展示
                    scenariosSection

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
        VStack(spacing: 16) {
            // 主标题
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 28))
                    .foregroundColor(.primaryBlue)
                Text("AI头部形象管理")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.textPrimary)
            }

            // 副标题 - 突出脱发解决
            VStack(spacing: 8) {
                Text("专为脱发人群打造")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primaryBlue)

                Text("植发、假发、发际线调整\n一键预览真实效果")
                    .font(.system(size: 15))
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }

            // 统计数据
            HStack(spacing: 40) {
                StatisticItem(number: "2.5亿+", label: "脱发人群")
                StatisticItem(number: "260亿+", label: "植发市场")
                StatisticItem(number: "AI驱动", label: "真实模拟")
            }
            .padding(.top, 8)
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
    }

    // MARK: - Core Features
    private var coreFeatures: some View {
        VStack(spacing: 16) {
            Text("核心功能")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            // 脱发检测
            FeatureCard(
                icon: "magnifyingglass.circle.fill",
                title: "脱发检测",
                description: "AI智能分析当前脱发程度",
                color: .orange,
                action: {
                    showHairLossDetection = true
                }
            )

            // 植发效果模拟
            FeatureCard(
                icon: "cross.case.fill",
                title: "植发效果模拟",
                description: "真实预览植发后的样子",
                color: .green,
                action: {
                    photoPickerVM.selectImageSource()
                }
            )

            // 假发试戴
            FeatureCard(
                icon: "person.crop.circle.badge.checkmark",
                title: "假发试戴",
                description: "360°预览假发佩戴效果",
                color: .blue,
                action: {
                    photoPickerVM.selectImageSource()
                }
            )

            // 发际线调整
            FeatureCard(
                icon: "ruler.fill",
                title: "发际线调整",
                description: "优化发际线形状和高度",
                color: .purple,
                action: {
                    photoPickerVM.selectImageSource()
                }
            )
        }
    }

    // MARK: - Pain Points Section
    private var painPointsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                Text("我们解决的问题")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.textPrimary)
            }

            VStack(spacing: 12) {
                PainPointRow(icon: "eye.slash.fill", text: "看不到效果：植发/假发效果无法提前预览")
                PainPointRow(icon: "questionmark.circle.fill", text: "不知道适合什么：不懂脸型与发型搭配")
                PainPointRow(icon: "exclamationmark.triangle.fill", text: "担心不自然：害怕植发或假发效果违和")
                PainPointRow(icon: "clock.fill", text: "决策困难：缺少可视化工具辅助决策")
            }
            .padding()
            .background(Color.secondaryGray)
            .cornerRadius(12)
        }
    }

    // MARK: - Scenarios Section
    private var scenariosSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("使用场景")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ScenarioCard(
                        icon: "cross.case.fill",
                        title: "植发前",
                        description: "预览植发效果\n降低决策焦虑",
                        color: .green
                    )

                    ScenarioCard(
                        icon: "person.crop.circle",
                        title: "假发选择",
                        description: "试戴不同款式\n找到最适合的",
                        color: .blue
                    )

                    ScenarioCard(
                        icon: "ruler.fill",
                        title: "发际线调整",
                        description: "模拟调整效果\n优化脸型比例",
                        color: .purple
                    )

                    ScenarioCard(
                        icon: "building.2.fill",
                        title: "线下机构",
                        description: "展示效果demo\n提升客户信任",
                        color: .orange
                    )
                }
            }
        }
    }
}

// MARK: - Statistic Item
struct StatisticItem: View {
    let number: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(number)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primaryBlue)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.textSecondary)
        }
    }
}

// MARK: - Feature Card
struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(color)
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.textPrimary)

                    Text(description)
                        .font(.system(size: 13))
                        .foregroundColor(.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.textSecondary)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: color.opacity(0.2), radius: 8, x: 0, y: 2)
        }
    }
}

// MARK: - Pain Point Row
struct PainPointRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.red)
                .frame(width: 24)

            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.textPrimary)

            Spacer()
        }
    }
}

// MARK: - Scenario Card
struct ScenarioCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(color)
                .frame(width: 80, height: 80)
                .background(color.opacity(0.1))
                .clipShape(Circle())

            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.textPrimary)

            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(width: 140)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}

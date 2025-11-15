//
//  HairstyleGenerationView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct HairstyleGenerationView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    @StateObject private var viewModel = HairstyleGenerationViewModel()
    @State private var showResultView = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // 加载动画
                loadingAnimation

                // 进度文本
                progressText

                // 进度条
                progressBar

                // 提示文本
                tipText

                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.generateHairstyles(from: image)
        }
        .onChange(of: viewModel.progress.stage) { newStage in
            if newStage == .complete {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showResultView = true
                }
            }
        }
        .fullScreenCover(isPresented: $showResultView) {
            HairstyleResultView(
                originalImage: image,
                results: viewModel.generatedResults,
                isPresented: $isPresented
            )
        }
    }

    // MARK: - Loading Animation
    private var loadingAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.secondaryGray, lineWidth: 8)
                .frame(width: 120, height: 120)

            Circle()
                .trim(from: 0, to: viewModel.progress.progress)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.primaryBlue, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 120, height: 120)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: viewModel.progress.progress)

            VStack {
                Image(systemName: "scissors")
                    .font(.system(size: 40))
                    .foregroundColor(.primaryBlue)
                    .rotationEffect(.degrees(viewModel.isGenerating ? 360 : 0))
                    .animation(
                        viewModel.isGenerating ?
                        Animation.linear(duration: 2).repeatForever(autoreverses: false) : .default,
                        value: viewModel.isGenerating
                    )

                Text("\(Int(viewModel.progress.progress * 100))%")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.textPrimary)
            }
        }
    }

    // MARK: - Progress Text
    private var progressText: some View {
        Text(viewModel.progress.stage.rawValue)
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.textPrimary)
    }

    // MARK: - Progress Bar
    private var progressBar: some View {
        VStack(alignment: .leading, spacing: 8) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondaryGray)
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.primaryBlue, .blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * viewModel.progress.progress, height: 8)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.progress.progress)
                }
            }
            .frame(height: 8)
        }
    }

    // MARK: - Tip Text
    private var tipText: some View {
        VStack(spacing: 8) {
            Text("生成中,约需 1-2 分钟")
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)

            Text("我们正在为您生成专属发型效果")
                .font(.system(size: 12))
                .foregroundColor(.textSecondary.opacity(0.8))
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    HairstyleGenerationView(
        image: UIImage(systemName: "photo")!,
        isPresented: .constant(true)
    )
}

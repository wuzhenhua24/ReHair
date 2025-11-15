//
//  HairstyleGenerationViewModel.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI
import Combine

class HairstyleGenerationViewModel: ObservableObject {
    @Published var progress: GenerationProgress = GenerationProgress(
        stage: .analyzing,
        progress: 0.0
    )
    @Published var isGenerating: Bool = false
    @Published var generatedResults: [HairstyleResult] = []
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func generateHairstyles(from image: UIImage) {
        isGenerating = true
        error = nil

        // 模拟生成过程
        simulateGeneration()
    }

    private func simulateGeneration() {
        // Stage 1: 分析
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.progress = GenerationProgress(stage: .analyzing, progress: 0.3)
        }

        // Stage 2: 生成
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.progress = GenerationProgress(stage: .generating, progress: 0.6)
        }

        // Stage 3: 处理
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.progress = GenerationProgress(stage: .processing, progress: 0.9)
        }

        // Stage 4: 完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [weak self] in
            self?.progress = GenerationProgress(stage: .complete, progress: 1.0)
            self?.isGenerating = false
            self?.createMockResults()
        }
    }

    private func createMockResults() {
        // TODO: 替换为实际的API调用
        let mockResults = [
            HairstyleResult(
                originalImageURL: "original_image",
                generatedImageURL: "generated_image_1",
                style: .short,
                tags: ["适合圆脸", "清爽"]
            ),
            HairstyleResult(
                originalImageURL: "original_image",
                generatedImageURL: "generated_image_2",
                style: .korean,
                tags: ["韩系中分", "时尚"]
            ),
            HairstyleResult(
                originalImageURL: "original_image",
                generatedImageURL: "generated_image_3",
                style: .natural,
                tags: ["自然发际线", "商务"]
            )
        ]
        generatedResults = mockResults
    }

    func reset() {
        progress = GenerationProgress(stage: .analyzing, progress: 0.0)
        isGenerating = false
        generatedResults = []
        error = nil
    }
}

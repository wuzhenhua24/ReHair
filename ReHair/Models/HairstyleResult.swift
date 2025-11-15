//
//  HairstyleResult.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import Foundation
import UIKit

struct HairstyleResult: Identifiable, Codable {
    let id: UUID
    let originalImageURL: String
    let generatedImageURL: String
    let style: HairstyleStyle
    let tags: [String]
    let createdAt: Date
    var isFavorite: Bool

    init(
        id: UUID = UUID(),
        originalImageURL: String,
        generatedImageURL: String,
        style: HairstyleStyle,
        tags: [String] = [],
        createdAt: Date = Date(),
        isFavorite: Bool = false
    ) {
        self.id = id
        self.originalImageURL = originalImageURL
        self.generatedImageURL = generatedImageURL
        self.style = style
        self.tags = tags
        self.createdAt = createdAt
        self.isFavorite = isFavorite
    }
}

// MARK: - Hairstyle Style
enum HairstyleStyle: String, Codable, CaseIterable {
    case short = "短发"
    case medium = "中长发"
    case long = "长发"
    case curly = "卷发"
    case straight = "直发"
    case korean = "韩系"
    case natural = "自然发际线"
    case businessCasual = "商务休闲"

    var displayName: String {
        return self.rawValue
    }

    var icon: String {
        switch self {
        case .short: return "scissors"
        case .medium: return "comb"
        case .long: return "sparkles"
        case .curly: return "hurricane"
        case .straight: return "arrow.down"
        case .korean: return "star.fill"
        case .natural: return "leaf.fill"
        case .businessCasual: return "briefcase.fill"
        }
    }
}

// MARK: - Generation Progress
struct GenerationProgress {
    var stage: GenerationStage
    var progress: Double // 0.0 - 1.0

    enum GenerationStage: String {
        case analyzing = "正在分析发际线..."
        case generating = "正在生成发型..."
        case processing = "正在处理图片..."
        case complete = "生成完成"

        var progress: Double {
            switch self {
            case .analyzing: return 0.3
            case .generating: return 0.6
            case .processing: return 0.9
            case .complete: return 1.0
            }
        }
    }
}

// MARK: - Gallery Item
struct GalleryItem: Identifiable {
    let id: UUID
    let imageURL: String
    let style: HairstyleStyle
    let tags: [String]
    let description: String

    init(
        id: UUID = UUID(),
        imageURL: String,
        style: HairstyleStyle,
        tags: [String] = [],
        description: String = ""
    ) {
        self.id = id
        self.imageURL = imageURL
        self.style = style
        self.tags = tags
        self.description = description
    }
}

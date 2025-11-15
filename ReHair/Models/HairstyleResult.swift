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
    // 脱发解决方案相关
    case hairTransplant = "植发效果"
    case hairlineAdjustment = "发际线调整"
    case wigSimulation = "假发试戴"
    case hairDensity = "增发效果"

    // 常规发型
    case short = "短发"
    case medium = "中长发"
    case long = "长发"
    case curly = "卷发"
    case straight = "直发"
    case korean = "韩系"
    case businessCasual = "商务休闲"

    var displayName: String {
        return self.rawValue
    }

    var icon: String {
        switch self {
        // 脱发解决方案图标
        case .hairTransplant: return "cross.case.fill"
        case .hairlineAdjustment: return "ruler.fill"
        case .wigSimulation: return "person.crop.circle.badge.checkmark"
        case .hairDensity: return "plus.circle.fill"

        // 常规发型图标
        case .short: return "scissors"
        case .medium: return "comb"
        case .long: return "sparkles"
        case .curly: return "hurricane"
        case .straight: return "arrow.down"
        case .korean: return "star.fill"
        case .businessCasual: return "briefcase.fill"
        }
    }

    var description: String {
        switch self {
        case .hairTransplant: return "真实模拟植发后效果"
        case .hairlineAdjustment: return "优化发际线形状"
        case .wigSimulation: return "预览假发佩戴效果"
        case .hairDensity: return "模拟增加发量后效果"
        case .short: return "清爽干练的短发造型"
        case .medium: return "时尚百搭的中长发"
        case .long: return "优雅迷人的长发"
        case .curly: return "浪漫柔美的卷发"
        case .straight: return "简约大方的直发"
        case .korean: return "流行的韩系风格"
        case .businessCasual: return "适合职场的发型"
        }
    }

    var category: StyleCategory {
        switch self {
        case .hairTransplant, .hairlineAdjustment, .wigSimulation, .hairDensity:
            return .hairLossSolution
        case .short, .medium, .long, .curly, .straight, .korean, .businessCasual:
            return .regularStyle
        }
    }
}

// MARK: - Style Category
enum StyleCategory: String {
    case hairLossSolution = "脱发解决方案"
    case regularStyle = "常规发型"
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

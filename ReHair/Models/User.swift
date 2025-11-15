//
//  User.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String?
    var phone: String?
    var avatarURL: String?
    var createdAt: Date
    var loginMethod: LoginMethod

    enum LoginMethod: String, Codable {
        case phone = "phone"
        case appleID = "apple_id"
        case guest = "guest"
    }

    init(
        id: UUID = UUID(),
        name: String,
        email: String? = nil,
        phone: String? = nil,
        avatarURL: String? = nil,
        createdAt: Date = Date(),
        loginMethod: LoginMethod = .guest
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.avatarURL = avatarURL
        self.createdAt = createdAt
        self.loginMethod = loginMethod
    }
}

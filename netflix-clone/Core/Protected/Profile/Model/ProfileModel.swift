//
//  Profile.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 31/12/25.
//

import Foundation

internal struct ProfileModel: Codable, Hashable, Sendable {
    let id: UUID?
    var avatarUrl: String?
    let email: String?
    var fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case avatarUrl = "avatar_url"
        case fullName = "full_name"
    }
}

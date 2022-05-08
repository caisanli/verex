//
//  Member.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/18.
//

import Foundation


/// 用户信息
struct Member: Hashable, Identifiable, Codable {
    var id: Int
    var username: String
    var url: String
    var avatarMini: URL
    var avatarNormal: URL
    var avatarLarge: URL
    var created: Int
    var lastModified: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case url
        case created
        case avatarMini = "avatar_mini"
        case avatarNormal = "avatar_normal"
        case avatarLarge = "avatar_large"
        case lastModified = "last_modified"
    }
}

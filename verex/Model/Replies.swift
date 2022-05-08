//
//  Replies.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/7.
//

import Foundation

struct Replies: Codable, Hashable, Identifiable {
    var id: Int // 回复id
    var memberId: Int // 用户id
    var lastModified: Int // 最后更新时间
    var contentRendered: String // html内容
    var content: String // 原内容
    var topicId: Int // 主题ID
    var created: Int // 创建时间
    var member: Member // 回复人员信息
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case created
        case member
        case memberId = "member_id"
        case lastModified = "last_modified"
        case contentRendered = "content_rendered"
        case topicId = "topic_id"
    }
}

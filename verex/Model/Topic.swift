//
//  Topic.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/14.
//

import Foundation


/// 主题信息
struct Topic: Identifiable, Codable {
    var id: Int
    var title: String // 标题
    var content: String // 原始内容
    var contentRendered: String // 转化后的HTML内容
//    var syntax: Int
    var url: URL
    var replies: Int // 回复数量
    var lastReplyBy: String // 最后回复的人
    var created: Int // 创建时间
    var lastModified: Int // 最后更新时间
    var lastTouched: Int
    var node: Node
    var member: Member
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
//        case syntax
        case url
        case replies
        case created
        case node
        case member
        case contentRendered = "content_rendered"
        case lastReplyBy = "last_reply_by"
        case lastModified = "last_modified"
        case lastTouched = "last_touched"
    }
}

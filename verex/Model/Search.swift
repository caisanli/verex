//
//  Search.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/6.
//

import Foundation

struct SearchResponse: Codable {
    var took: Int // 搜索耗时
    var timed_out: Bool // 是否超时
    var total: Int // 主题总数
    var hits: [SearchHit] // 列表
}

struct SearchHit: Codable {
        
    var _source: SearchHit.Source
    
    struct Source: Codable, Identifiable {
        var id: Int // 主题ID
        var node: Int // 节点ID
        var replies: Int // 回复数量
        var created: String // 创建时间
        var member: String // 作者
        var title: String // 主题标题
        var content: String // 主题内容
    }
}

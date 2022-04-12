//
//  Node.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/11.
//

import Foundation

struct Node: Codable, Hashable, Identifiable {
    var id: Int
    var name: String // 唯一name
    var title: String // 标题
    var avatar_large: String // 大图
    var avatar_normal: String // 中图
    var avatar_mini: String // 小图
//    var url: String // 节点主页
    var topics: Int // 节点下的主题数量
//    var footer: String
    var header: String // 节点描述
//    var stars: Int //
//    var aliases: [String]
//    var root: Bool
//    var parent_node_name: String // 父节点名称
}

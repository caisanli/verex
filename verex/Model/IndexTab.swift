//
//  IndexTab.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/11.
//

import Foundation

enum IndexTabEnum: String {
//    case all
    case tech
//    case creative
    case play
    case apple
    case jobs
    case deals
    case city
    case qna
    case hot
    case r2
    case nodes
    case members

    func displayName() -> String {
        var name: String = ""
        switch(self) {
//            case .all:
//                name = "全部"
            case .tech:
                name = "技术"
//            case .creative:
//                name = "创意"
            case .play:
                name = "好玩"
            case .apple:
                name = "Apple"
            case .jobs:
                name = "酷工作"
            case .deals:
                name = "交易"
            case .city:
                name = "城市"
            case .qna:
                name = "问与答"
            case .hot:
                name = "最热"
            case .r2:
                name = "r2"
            case .nodes:
                name = "节点"
            case .members:
                name = "关注"
        }
        return name;
    }
}

struct IndexTabItem {
    var name: IndexTabEnum
    var title: String
    
    init(_ name: IndexTabEnum) {
        self.name = name
        self.title = name.displayName()
    }
}

// 首页Tab数据
let IndexTabData: [IndexTabItem] = [
//    IndexTabItem(IndexTabEnum.all),
    IndexTabItem(IndexTabEnum.tech),
//    IndexTabItem(IndexTabEnum.creative),
    IndexTabItem(IndexTabEnum.play),
    IndexTabItem(IndexTabEnum.apple),
    IndexTabItem(IndexTabEnum.jobs),
    IndexTabItem(IndexTabEnum.deals),
    IndexTabItem(IndexTabEnum.city),
    IndexTabItem(IndexTabEnum.qna),
    IndexTabItem(IndexTabEnum.hot),
    IndexTabItem(IndexTabEnum.r2),
    IndexTabItem(IndexTabEnum.nodes),
    IndexTabItem(IndexTabEnum.members)
]

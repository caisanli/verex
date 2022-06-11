//
//  IndexTab.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/11.
//

import Foundation

enum IndexTabEnum: String {
    case new
    case hot

    func displayName() -> String {
        var name: String = ""
        switch(self) {
            case .new:
                name = "最新"
            case .hot:
                name = "最热"
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
    IndexTabItem(IndexTabEnum.new),
    IndexTabItem(IndexTabEnum.hot),
]

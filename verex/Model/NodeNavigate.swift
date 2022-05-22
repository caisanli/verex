//
//  NodeNavigate.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/22.
//

import Foundation
import SwiftSoup

struct NodeNavigateInfo: HtmlParsable {
    var items: [NodeNavigateItem] = []
    
    init() {}

    init?(_ html: Element? = nil) {
        guard html != nil else { return }
        do {
            let box = try html?.select("#Main .box").last()
            let tableList = try box?.select("table");
            tableList?.forEach({ table in
                let id = UUID().uuidString
                let name = try! table.select("tr td:nth-child(1)").text()
                let linkList = try! table.select("tr td:nth-child(2) a")
                var children: [NodeNavigateItem] = []
                linkList.forEach { link in
                    let name = try! link.text()
                    let href = try! link.attr("href")
                    let id = href.split(separator: "/")[href.split(separator: "/").count - 1]
                    let child = NodeNavigateItem(id: String(id), name: name)
                    children.append(child)
                }
                self.items.append(NodeNavigateItem(id: id, name: name, children: children))
            })
        } catch {
            print(error)
        }
    }
}

struct NodeNavigateItem: Identifiable {
    var id: String
    var name: String
    var children: [NodeNavigateItem]? = []
}

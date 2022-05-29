//
//  NodeNavigateVM.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/29.
//

import Foundation

class NodeNavigateVM: ObservableObject {
    @Published var items: [NodeNavigateItem] = []
    @Published var nodes: [NodeNavigateItem] = []
    @Published var active: String = ""
    
    func query() {
        // 如果不为空就不获取数据
        guard items.isEmpty else {
            self.setActive()
            return
        }
        
        RequestManager.getNodeNavigate { result in
            let nodes = result.items
            self.items = nodes;
            self.setActive()
        }
    }
    
    func setActive() {
        let nodes = self.items
        if !nodes.isEmpty {
            let item = nodes[0]
            self.nodes = item.children!
            self.active = item.id
        }
    }
    
    func setActive(_ item: NodeNavigateItem) {
        self.nodes = item.children!
        self.active = item.id
    }
}

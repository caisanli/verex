//
//  HomeView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI

struct HomeView: View {
    @State var tabIndex: IndexTabEnum = IndexTabData[0].name
    @State var page: Int = 1
    @State private var list: [Topic] = []
    @State var params = GET_TOPICES_PARAMS(node_name: IndexTabData[0].name.rawValue)
    var body: some View {
        VStack {
            // 头部导航
            HomeHead()
            // 节点标签页
            HomeNodeTabs(tabIndex: $tabIndex, tabs: IndexTabData, onTabChange: self.onTabChange)
            // 主内容
            HomeSection(list: self.list)
        }
        .onAppear {
            page = 1;
            query()
        }
    }
    
    
    /// 监听节点标签页改变
    /// - Parameter name: 当前选中标签节点
    func onTabChange(name: IndexTabEnum) {
        self.tabIndex = name
        self.params.node_name = name.rawValue
        self.page = 1
        self.query()
    }
    
    
    /// 查询主题列表
    /// - Parameter name: 节点的 name
    func query() {
        switch self.tabIndex {
        case .new:
            RequestManager.getNew() { result in
                self.list = result
            }
        case .hot:
            RequestManager.getHot() { result in
                self.list = result
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI

struct HomeView: View {
    @State var tabIndex: IndexTabEnum = IndexTabData[0].name
    var body: some View {
        VStack {
            // 头部导航
            HomeHead()
            // 节点标签页
            HomeNodeTabs(tabIndex: $tabIndex, tabs: IndexTabData, onTabChange: self.onTabChange)
            // 主内容
            ScrollView {
                // Text("Scroll View"')
            }
        }        
    }
    
    
    /// 监听节点标签页改变
    /// - Parameter name: 当前选中标签节点
    func onTabChange(name: IndexTabEnum) {
        print("name：\(name.rawValue)")
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

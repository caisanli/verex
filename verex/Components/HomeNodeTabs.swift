//
//  HomeNodeTabs.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI


/// 首页节点标签页
struct HomeNodeTabs: View {
    // 当前选中 tab
    @Binding var tabIndex: IndexTabEnum
    // 所有 tab
    var tabs: [IndexTabItem]
    // 监听tab 改变
    var onTabChange: (_ name: IndexTabEnum) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 10) {
                ForEach(tabs, id: \.name) { tab in
                    let isActive = tab.name == tabIndex;
                    let color: Color = isActive ? .primary : .secondary
                    Text(tab.title)
                        .foregroundColor(color)
                        .font(.headline)
                        .tag(tab.name)
                        .onTapGesture {
                            onTapTab(tab: tab)
                        }
                }
            }
            .padding(
                EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            )
        }
    }
    
    /// 点击单个 tab
    /// - Parameter tab: 当前 tab
    func onTapTab(tab: IndexTabItem) {
        self.tabIndex = tab.name
        self.onTabChange(tab.name)
    }
}

//struct HomeNodeTabs_Previews: PreviewProvider {
//    @State private var tabIndex = IndexTabData[0].name
//
//    static var previews: some View {
//        HomeNodeTabs(tabIndex: $tabIndex)
//    }
//}

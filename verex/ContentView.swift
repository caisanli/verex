//
//  ContentView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/6.
//

import SwiftUI

struct ContentView: View {
    
    enum TabEnum {
        case index
        case nodes
        case user
    }
    
    @State var section = TabEnum.index
    
    var body: some View {
        NavigationView {
            TabView(selection: $section) {
                HomeView().tabItem {
                    Image(systemName: "house")
                }
                .tag(TabEnum.index)
                .navigationBarHidden(true)
                
                NodesView().tabItem {
                    Image(systemName: "square.grid.2x2")
                }
                .tag(TabEnum.nodes)
                .navigationTitle("节点信息")

                
                UserView().tabItem {
                    Image(systemName: "person")
                }
                .tag(TabEnum.user)
                .navigationTitle("用户信息")
            }
            .id(section)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

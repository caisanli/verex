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
        TabView(selection: $section) {
            HomeView().tabItem {
                Image(systemName: "house")
            }.tag(TabEnum.index)
            
            NodesView().tabItem {
                Image(systemName: "square.grid.2x2")
            }.tag(TabEnum.nodes)
            
            UserView().tabItem {
                Image(systemName: "person")
            }.tag(TabEnum.user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  HomeSection.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/14.
//

import SwiftUI

struct HomeSection: View {
    var list: [Topic]
    var body: some View {
        ScrollView {
            if (list.count == 0) {
                Label("无数据", systemImage: "tray")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            ForEach(list) { topic in
                HomeNodeTopic(topic: topic)
            }
        }
    }
}


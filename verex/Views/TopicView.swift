//
//  TopicView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/21.
//

import SwiftUI

struct TopicView: View {
    @State var topic: Topic
    var body: some View {
//        Text("当前主题ID：\(topic.id)")
        ScrollView() {
            TopicInfo(topic: topic)
        }
    }
}

//struct TopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicView()
//    }
//}

//
//  TopicView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/21.
//

import SwiftUI

struct TopicView: View {
    @State var topic: Topic
    @State var params = GET_REPILES_PARAMS()
    @State var list: [Replies] = []
    
    var body: some View {
        ScrollView() {
            // 主题详情
            TopicInfo(topic: topic)
            // 主题回复列表
            ForEach(0..<list.count, id: \.self) { index in
                TopicReplies(replies: list[index], index: index)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
        }
        .onAppear {
            params.page = 1
            params.topic_id = topic.id
            query()
        }
    }
    
    
    /// 获取回复列表
    func query() {
        RequestManager.getRelipes(params: params) { result in
            if (params.page == 1) {
                list = result
            } else {
                list += result
            }
        }
    }
    
    
}

//struct TopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicView()
//    }
//}

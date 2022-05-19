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
        VStack {
            ScrollView() {
                // 主题详情
                TopicInfo(topic: topic)
                // 主题回复列表
                ForEach(0..<list.count, id: \.self) { index in
                    let replies = list[index]
                    let isOwner = replies.memberId == topic.member.id
                    TopicReplies(replies: replies, index: index, isOwner: isOwner)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                
                HStack {
                    Text("没有更多回复")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 8)
            }
            // 底部输入框
            TopicFooter { reply in
                onSubmitReply(reply)
            } onThank: {
                onThank()
            } onCollection: {
                onCollection()
            }

        }
        .onAppear {
            params.page = 1
            params.topic_id = topic.id
            query()
        }
    }
    
    // 监听感谢
    func onThank() {
        print("感谢")
    }
    
    /// 监听收藏
    func onCollection() {
        print("收藏")
    }
    
    /// 监听提交回复
    /// - Parameter reply: 回复内容
    func onSubmitReply(_ reply: String) {
        print(reply)
    }
    
    /// 获取回复列表
    func query() {
        RequestManager.getRelipes(params: params) { result in
            let newResult = result.sorted { reply1, reply2 in
                return reply1.created < reply2.created
            }
            if (params.page == 1) {
                list = newResult
            } else {
                list += newResult
            }
        }
    }
    
    
}

//struct TopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicView()
//    }
//}

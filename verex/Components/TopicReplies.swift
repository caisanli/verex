//
//  TopicReplies.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/7.
//

import SwiftUI

struct TopicReplies: View {
    var replies: Replies
    var index: Int
    var body: some View {
        HStack {
            // 头像
            AsyncImage(url: replies.member.avatarNormal) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            
            VStack {
                //
                HStack {
                    // 用户名称
                    Text(replies.member.username)
                    // 回复时间
                    HowLongAgo(time: replies.created)
                    Spacer()
                    // 感谢
                    Image(systemName: "heart")
                    // 楼层
                    Text("#\(index)")
                }
                // 回复内容
//                HTMLLabelView(htmlContent: replies.contentRendered)
                // 分割线
                Divider()
            }
            
        }
        
    }
}

//struct TopicReplies_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicReplies()
//    }
//}

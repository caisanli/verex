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
    var isOwner: Bool
    var body: some View {
        HStack(alignment: .top) {
            // 头像
            AsyncImage(url: replies.member.avatarNormal) { image in
                image.resizable()
                    .cornerRadius(4)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                //
                HStack {
                    // 用户名称
                    Text(replies.member.username)
                        .font(.system(size: 16))
                    // 是否是楼主
                    if isOwner {
                        Text("楼主")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .padding(2)
                            .background(.blue)
                            .cornerRadius(2)
                    }
                    // 回复时间
                    HowLongAgo(time: replies.created)
                    Spacer()
                    // 楼层
                    Text("#\(index)")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
                // 回复内容
                RichText { replies.contentRendered }
                    .padding([.bottom], 8)
                
                // 操作栏
                HStack() {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.bubble")
                        Text("回复")
                    }
                    .padding([.trailing], 8)
                    .onTapGesture {
                        print("点击了回复")
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                        Text("感谢")
                    }
                    .onTapGesture {
                        print("点击了感谢")
                    }
                    
                }
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding([.bottom], 8)
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

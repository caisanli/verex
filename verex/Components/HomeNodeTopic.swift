//
//  HomeNodeTopic.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/17.
//

import SwiftUI

struct HomeNodeTopic: View {
    let topic: Topic
    var body: some View {
        HStack(alignment: .top) {
            // 用户头像
            AsyncImage(url: topic.member.avatarNormal) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 8) {
                // 主题标题
                Text(topic.title)
                    .foregroundColor(.primary)
                    .font(.subheadline)
                    .lineLimit(2)
                
                // 一些信息
                HStack(alignment: .center, spacing: 4) {
                    Text(topic.member.username)
                    Circle().fill(.gray).frame(width: 3, height: 3)
                    Image(systemName: "text.bubble")
                    Text(String(topic.replies))
                    
                    // 间隔
                    Spacer()
                    
                    Text(topic.node.title)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(2)
                    
                }
                .foregroundColor(.secondary)
                .font(.footnote)
                
                // 一些信息
                HStack(alignment: .center) {
                    Text("最后回复来自：\(topic.lastReplyBy)")
                    
                    Spacer()
                    
                    // 距离当前时间多久
                    Text("几秒前")
                }
                .foregroundColor(.gray)
                .font(.footnote)
                
                // 分割线
                Divider()
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 4, trailing: 16))
    }
    
    
//    func getHowLongAgo(time: Int) -> String {
//        let timeInterval: TimeInterval = Date().timeIntervalSince1970
//        let currentTime = Int(timeInterval)
//        var second = currentTime - time
//        let units = ["秒", "分", "时", "天"]
//        var step = 0
//        var str = String(second) + units[step]
//
//        while (second < 60 && step < units.count) {
//            step += 1
//            second = second / 60
//        }
//
//        return ""
//    }
}

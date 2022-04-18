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
        HStack {
            // 用户头像
            AsyncImage(url: topic.member.avatarNormal) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            VStack {
                // 主题标题
                Text(topic.title)
                    .fontWeight(.medium)
                    .font(.title)
                
                // 一些信息
                HStack(alignment: .center) {
                    Text(topic.member.username)
                    Circle().fill(.gray).frame(width: 5, height: 5)
                    Image(systemName: "text.bubble")
                    Text(String(topic.replies))
                    
                    // 间隔
                    Spacer()
                    
                    //
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd"
                    
                }
            }
        }
    }
    
    
    func getHowLongAgo(time: Int) -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let currentTime = Int(timeInterval)
        let second = currentTime - time
        let units = ["秒", "分", "时", "天"]
        var step = 0
        var str = ""
        
        while (second < 60) {
            
        }
        
        currentTime - time
//        now.formatted(.number)
        return ""
    }
}

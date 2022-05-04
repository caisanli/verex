//
//  TopicInfo.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/25.
//

import SwiftUI

struct TopicInfo: View {
    var topic: Topic
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // 用户头像
                AsyncImage(url: topic.member.avatarNormal) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                //
                VStack(alignment: .leading, spacing: 4) {
                    // 用户名和节点名称
                    HStack {
                        Text(topic.member.username)
                        NodeTag(tag: topic.node.title)
                    }
//                    .padding([.bottom], 4)
                    // 时间、点击数、收藏数
                    HStack {
                        HowLongAgo(time: topic.lastTouched)
                    }
                }
            }
            // 主题标题
            Text(topic.title).fontWeight(.medium)
            // 主题内容
            HTMLStringView(htmlContent: topic.contentRendered)
        }
        .padding()
    }
}

//struct TopicInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicInfo()
//    }
//}

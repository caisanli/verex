//
//  TopicFooter.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/17.
//

import SwiftUI

struct TopicFooter: View {
    @FocusState var replyFocused: Bool
    @State var reply: String = ""
    let onSubmit: (_ reply: String) -> Void
    let onThank: () -> Void
    let onCollection: () -> Void
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                TextField("输入回复内容", text: $reply)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 14))
                    .padding(.trailing, 0)
                    .focused($replyFocused)
                    .onSubmit {
                        submit()
                    }
                // 提交回复按钮
                Image(systemName: "arrow.up.circle")
                    .foregroundColor(!reply.isEmpty ? .blue : .gray)
                    .onTapGesture {
                        submit()
                    }
                // 收藏按钮
                Image(systemName: "star.circle")
                    .onTapGesture {
                        onCollection()
                    }
                // 感谢按钮
                Image(systemName: "yensign.circle")
                    .onTapGesture {
                        onThank()
                    }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
        }
    }
    
    func submit() {
        onSubmit(reply)
        reply = ""
    }
}

//struct TopicFooter_Previews: PreviewProvider {
//    static var previews: some View {
//        TopicFooter()
//    }
//}

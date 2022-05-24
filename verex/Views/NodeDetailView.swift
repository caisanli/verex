//
//  NodeDetailView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/22.
//

import SwiftUI

struct NodeDetailView: View {
    var nodeName: String;
    @State var info: Node = Node()
    @State var list: [Topic] = []
    var body: some View {
        // 节点一些信息
        ScrollView {
            HStack {
                HStack {
                    AsyncImage(url: URL(string: info.avatar_large)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("主题数：\(info.topics)")
                            Spacer()
                            Text("加入收藏")
                                .foregroundColor(.yellow)
                        }
                        .font(.system(size: 16))
                        .padding(.bottom, 8)
                        
                        RichText {
                            info.header
                        }
                    }
                }
                .padding()
            }
            .foregroundColor(.white)
            .background(.blue)
            
            ForEach(list) { topic in
                HomeNodeTopic(topic: topic)
            }
        }
        .onAppear {
            getInfo()
            getTopicsList()
        }
    }
    
    /// 获取节点信息
    func getInfo() {
        let params = GET_NODE_INFO_PARAMS(name: nodeName)
        RequestManager.getNodeInfo(params: params) { info in
            self.info = info
            print(info)
        }
    }
    
    
    /// 获取主题列表
    func getTopicsList() {
        let params = GET_TOPICES_PARAMS(node_name: nodeName)
        RequestManager.queryTopics(params: params) { result in
            self.list = result
        }
    }
}

struct NodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NodeDetailView(nodeName: "apple")
    }
}

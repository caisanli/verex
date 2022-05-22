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
    var body: some View {
        VStack {
            
        }
        .onAppear {
            getInfo()
        }
    }
    
    /// 获取节点信息
    func getInfo() {
        let params = GET_NODE_INFO_PARAMS(name: nodeName)
        RequestManager.getNodeInfo(params: params) { info in
            self.info = info
        }
    }
}

struct NodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NodeDetailView(nodeName: "apple")
    }
}

//
//  NodeDetailView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/22.
//

import SwiftUI

struct NodeDetailView: View {
    var nodeName: String;
    var body: some View {
        Text("这是\(nodeName)")
    }
}

struct NodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NodeDetailView(nodeName: "apple")
    }
}

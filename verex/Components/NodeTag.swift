//
//  NodeTag.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/4.
//

import SwiftUI

struct NodeTag: View {
    let tag: String
    var body: some View {
        Text(tag)
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(2)
            .background(.gray)
            .cornerRadius(2)
    }
}

struct NodeTag_Previews: PreviewProvider {
    static var previews: some View {
        NodeTag(tag: "科技")
    }
}

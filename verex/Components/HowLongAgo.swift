//
//  HowLongAgo.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/4.
//

import SwiftUI

struct HowLongAgo: View {
    let time: Int
    var body: some View {
        Text("3分钟以前")
            .foregroundColor(.gray)
            .font(.footnote)
    }
}

struct HowLongAgo_Previews: PreviewProvider {
    static var previews: some View {
        HowLongAgo(time: 3)
    }
}

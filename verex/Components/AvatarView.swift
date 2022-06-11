//
//  AvatarView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/25.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
    var url: String? = ""
    var size: CGFloat = AvatarView.baseSize
    static var baseSize: CGFloat = 35.0
    var body: some View {
        KFImage.url(URL(string: url ?? ""))
            .placeholder {
                Image("default")
            }
            .fade(duration: 0.25)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .cornerRadius(4)
    }
    
    init(url: String? = "", size: CGFloat? = AvatarView.baseSize) {
        self.url = url
        self.size = size ?? AvatarView.baseSize
    }
    
    init(url: URL, size: CGFloat? = AvatarView.baseSize) {
        print(url.absoluteString)
        self.url = url.absoluteString
        self.size = size ?? AvatarView.baseSize
       
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

//
//  SearchView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/31.
//

import SwiftUI
import WrappingHStack

struct SearchView: View {
    @State var text: String = ""
    @State var list: [String] = ["caisanli", "wangwu", "didi", "七八七八", "午觉午觉", "节日快乐", "天池"]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                TextField("输入内容", text: $text)
                    .frame(height: 48)
                    .textFieldStyle(.plain)
                
            }
            
            Divider()
                .padding(.bottom, 8)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("搜索历史")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                WrappingHStack(list, lineSpacing: 8) { item in
                    Text(item)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(.blue)
                        .cornerRadius(4)
                }
                
            }
        }
        .padding()
        .padding(.top, 0)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

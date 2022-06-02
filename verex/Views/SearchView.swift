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
    @State var list: [String] = []
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                TextField("输入内容", text: $text)
                    .frame(height: 48)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        setHistory()
                    }
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
        .onAppear {
            getHistory()
        }
    }
    
    func setHistory() {
        let oldhistory: String = UserDefaultKeys.string(.searchHistory) ?? ""
        let newHistory: String = "\(oldhistory)&\(self.text)"
        UserDefaultKeys.set(value: newHistory, key: .searchHistory)
        self.list.append(self.text)
    }
    
    func getHistory() {
        let history: String = UserDefaultKeys.string(.searchHistory) ?? ""
        self.list = history.split(separator: "&").map({ item in
            String(item)
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
